class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  def index
    user_type = params[:user_type]
    if user_type == "admin"
      @users = User.where(user_type: "admin")
      render json: @users
    else
      @users = User.where(user_type: "user")
      render json: @users
    end
  end

  def gem_searching
    debugger
    # @users = User.search(name: params[:name]).result
    # render json: @users

    # @search = User.ransack(params[:name])
    # @user = @search.result
    # render json: @user

    @search = User.ransack(params[:name])
    @users = @search.result
    render json: @users
    
    # @users = User.all  
    # @name = User.ransack(params[:name])
    # @people = @name.result.group('users.name')
    # @search.build_condition
    # render json: @user

    
    # @search = User.ransack(search_params)
    # @user = @search.result(distinct: true)
    # render json: @user

    # @name = User.ransack(params[:name])
    # @user = @name.result(distinct: true)
    # render json: @user
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now!
      render json: @user
    else
      render json: { error: "Unable to create user"}, status: 400
    end
  end

  def update
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

  private

    def user_params
      params.permit(:name, :age, :email, :user_type)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def search_params
      debugger
      params.permit(:name)
    end
end
