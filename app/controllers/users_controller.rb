class UsersController < ApplicationController
  module UserHelpers
  def find_user
    User.find_by(username: params[:username])
  end
  def authorized?
    login(@user.id) if @user && @user.authenticate(params[:password])
    session[:user_id]
  end

  def new_user
    @user = User.create(params)
    login(@user.id) if @user.save
  end

  def current_user
    User.find(session[:user_id])
  end

  def current_username
    if logged_in?
      current_user.username
    else
      "Guest"
    end
  end

  def find_user_by_slug
    User.find_by_slug(params[:slug])
  end

  def login(user_id)
    session[:user_id] = user_id
  end

  def logged_in?
    !!session[:user_id]
  end

  def logout
    session.clear
  end

  end
  before do
    set_title
  end


  get '/users/new' do
  @title = "Signup" 
    if logged_in?
      redirect '/meals/index'
    else
      erb :"/users/new"
    end
  end

  get '/users/login' do
    @title = "Login"
    if logged_in?
      redirect to "/meals/index"
    else 
      erb :"/users/login"
    end
  end

  post '/users/new' do
    if new_user
      redirect to "/"
    else
      redirect to "/users/new"
    end
  end

  post '/users/login' do
    @user = find_user
    if authorized?
      redirect '/meals/index'
    else
      redirect "/users/new"
    end
  end

  get('/users/logout') {logout; redirect to "/"}

  get '/users/:slug' do
    @user = find_user_by_slug
    erb :"/users/show"
  end

end




















