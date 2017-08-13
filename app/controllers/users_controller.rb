class UsersController < ApplicationController
  def index
    if current_user
      @users = User.all
      render "index.html.erb"
    else
      flash[:warning] = "You need to be logged in to see this page."
      redirect_to "/login"
    end
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

  def show
    if current_user
      user_id = params[:id]
      @user = User.find_by(id: user_id)
      render "show.html.erb"
    else
      flash[:warning] = "You need to be logged in to see this page."
      redirect_to "/login"
    end
  end

  def edit
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    render "edit.html.erb"
  end

  def update
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    @user.name = params[:form_name]
    @user.image = params[:form_image]
    @user.attachment = params[:form_attachment]

    if @user.save
      flash[:success] = "Profile Successfully Updated!"
      redirect_to "/users/#{@user.id}"
    else
      @user = User.all
      render "edit.html.erb"
    end
  end

  def destroy
    
  end
end