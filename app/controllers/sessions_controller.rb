class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticate the user
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}."
        redirect_to "/places"
      else
        flash["notice"] = "The credentials entered do not match our system. Please try again"
        redirect_to "/login"
      end
    else
      flash["notice"] = "Please use the sign-up link to register."
      redirect_to "/login"
    end
  end

  def destroy
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/login"
  end
end
