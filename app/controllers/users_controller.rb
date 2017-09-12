class UsersController < ApplicationController
  def index
    if current_user
#       require 'keen'    
#       Keen.publish(:signups, {
#         :username => current_user.name,
#         :referred_by => "NOT SURE WHAT THIS IS"
# })
      puts "-" * 50
      p session[:access_token]
      p "Bearer #{session[:access_token]}"
      puts "-" * 50
      if session[:access_token]
        @linkedin_users = Unirest.get(
          "https://api.linkedin.com/v1/people/~?format=json",
          headers: {
            "x-li-format" => "json",
            "Connection" => "Keep-Alive",
            "Authorization" => "Bearer #{session[:access_token]}"
          },
        ).body
      end
      @users = User.where.not(id: current_user.id)
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

  def linkedin
    render "linkedin.html.erb"
  end

  def register
    session[:linkedin_state] = "DCEeFWf45A53sdfKef424"
    redirect_to "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=#{ENV["linkedin_id"]}&redirect_uri=http://localhost:3000/linkedin_callback&state=#{session[:linkedin_state]}&scope=r_basicprofile"
  end

  def linkedin_callback

    puts "-" * 50
    puts "linkedin_callback"
    p params
    puts "-" * 50

    session[:linkedin_code] = params[:code]
    if session[:linkedin_state]  == params[:state]
      @response = Unirest.post(
        "https://www.linkedin.com/oauth/v2/accessToken?Content-Type=application/x-www-form-urlencoded&grant_type=authorization_code&code=#{session[:linkedin_code]}&redirect_uri=http://localhost:3000/linkedin_callback&client_id=#{ENV["linkedin_id"]}&client_secret=#{ENV["linkedin_secret"]}"
      ).body

      puts "-" * 50
      puts "linkedin_callback post"
      p @response
      puts "-" * 50

      session[:access_token] = @response["access_token"]
      session[:expires_in] = @response["expires_in"]
    end
    redirect_to "/users"
  end

  def data
    @profile = Unirest.get(
      "https://api.fitbit.com/1/user/-/profile.json",
      headers: {
        "Authorization" => "Bearer #{session[:access_token]}"
      }
    ).body
  end
end