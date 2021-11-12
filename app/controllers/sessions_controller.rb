class SessionsController < ApplicationController
  def create
    @session = session_params
    @user = User.find_by_email(@session[:email])
    # If the user exists AND the password entered is correct.
    if @user && @user.authenticate(@session[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = @user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      @session[:error] = "Incorrect username and/or password."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end


  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
end
