class SessionsController < ApplicationController
  def new
  end

  def create
    # haetaan käyttäjä tietokannasta
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
    else
        redirect_to :back, notice: "Username and/or password mismatch"
    end

  end

  def destroy
    # nollataan session
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulleen
    redirect_to :root
  end
end
