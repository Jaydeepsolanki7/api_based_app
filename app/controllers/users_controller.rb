class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def admins
    @user = User.where(user_type: "admin")
    render json: @user
  end

  def normal_user
    @user = User.where(user_type: "user")
    render json: @user
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: @user
    else
      render json: {error: "Unable to show User"}, status: 400
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      render json: @user
    else
      render json: { error: "Unable to create user"}, status: 400
    end
  end

  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      # render json: { message: "User succesfully updated."}, status: 200
    else
      render json: {error: "Unable to update User"}, status: 400
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy()
      # render json: { message: "User successfully deleted" }
    else
      render json: { error: "unable to delete user"}, status: 400
    end
  end

  private

    def user_params
      params.permit(:name, :age, :email)
    end
end
