class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.exists?(email: params["user"]["email"]) || User.exists?(username: params["user"]["username"])
      flash[:notice] = "A user with that email or username already exists."
      redirect_to "/users/new"
    else
    @user = User.new
    @user["username"] = params["user"]["username"]
    @user["email"] = params["user"]["email"]
    @user["password"] = BCrypt::Password.create(params["user"]["password"])
    @user.save
    redirect_to "/places"
  end
end
end
