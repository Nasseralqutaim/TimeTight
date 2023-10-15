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
    nil 
  end

  def authorize_resource_owner!(resource)
    owner = resource.respond_to?(:user) ? resource.user : resource.initiator
    unless current_user && current_user == owner
      render json: { error: 'Not authorized' }, status: :forbidden
    end
  end
end
