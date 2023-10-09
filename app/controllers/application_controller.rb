class ApplicationController < ActionController::API

  protected

  def current_user
    auth_headers = request.headers["Authorization"]
    if auth_headers.present? && auth_headers[/(?<=\A(Bearer ))\S+\z/]
      token = auth_headers[/(?<=\A(Bearer ))\S+\z/]
      if token
        begin
          decoded_token = JWT.decode(
            token,
            Rails.application.credentials.fetch(:secret_key_base),
            true,
            { algorithm: "HS256" }
          )
          return User.find_by(id: decoded_token[0]["user_id"])
        rescue JWT::ExpiredSignature, JWT::DecodeError
          nil
        end
      end
    end
    nil # Explicitly return nil if no user is found or if there's an error
  end

  def authorize_resource_owner!(resource)
    unless current_user && current_user == resource.user
      render json: { error: 'Not authorized' }, status: :forbidden
    end
  end
end
