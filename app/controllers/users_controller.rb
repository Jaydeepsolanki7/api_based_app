class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  def index
    user_type = params[:user_type]
    if user_type == "admin"
      @users = User.where(user_type: "admin")
      render json: @users
    elsif user_type == "user"
      @users = User.where(user_type: "user")
      render json: @users
    else
      @users = User.all
      render json: @users
    end
  end

  
  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
      UserMailer.welcome_email(send_at = 1.hour.from_now,@user).deliver_later
      UserMailerWorkerWorker.perform_in(1.hour, @user.id)
    else
      render json: { error: "Unable to create user"}, status: 400
    end
  end
  
  def update
    debugger
    if @user.update(user_params)
      render json: { message: "User succesfully updated."}, status: 200
    else
      render json: {error: "Unable to update User"}, status: 400
    end
  end
  
  def destroy
    if @user.destroy()
      render json: { message: "User succesfully deleted."}, status: 200
      
    else
      render json: { error: "unable to delete user"}, status: 400
    end
  end
  
  def search
    name = params[:name]
    @users = User.where('name LIKE ?', "%#{name}%")
    render json: @users
  end
  
  def gem_searching
    @users = User.search(params[:name])
    render json: @users
  end

  private

    def user_params
      params.require(:user).permit(:name, :age, :email, :user_type)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
