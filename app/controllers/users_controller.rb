class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  def show
    render json: @user
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
    # Permit the parameters that you require for user creation and updating.
    # Replace :attribute_1, :attribute_2, etc. with the actual attributes of your User model.
    params.require(:user).permit(:attribute_1, :attribute_2, ...)
  end
end
