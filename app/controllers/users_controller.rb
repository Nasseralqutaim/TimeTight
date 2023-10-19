class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      jwt = JWT.encode(
        { user_id: @user.id, exp: 24.hours.from_now.to_i },
        Rails.application.credentials.fetch(:secret_key_base),
        "HS256"
      )
      render json: { jwt: jwt, email: @user.email, user_id: @user.id }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  def show
    render json: @call_sessions.as_json(only: [:id, :initiator_id, :recipient_id, :start_time, :end_time], include: [initiator: { only: :username }, recipient: { only: :username }])

  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
