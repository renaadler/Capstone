class UsersController < ApplicationController
  def index
    # if current user
      @users = User.all
      render "index.html.erb"
    # else
    #   flash[:warning] = "Invalid email or password!"
    #   redirect_to "/login"
    # end
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    render "show.html.erb"
  end

  def new
    render "new.html.erb" 
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]    
      )
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Account Created!"
      redirect_to "/users/#{user.id}"
    else
      flash[:warning] = "Invalid email or password"
      redirect_to "/signup"
    end
  end
end