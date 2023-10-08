class ApplicationController < ActionController::Base

  def authorize_resource_owner!(resource)
    unless current_user == resource.user
      render json: { error: 'Not authorized' }, status: :forbidden
    end
  end
end
