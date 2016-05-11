class UsersController < ApplicationController
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
      redirect to "/"
    else 
      erb :"/users/login"
    end
  end

  post '/users/new' do
    @user = User.create(params)
    login(@user.id) if @user.save
    unless @user.errors
      redirect to "/"
    else
      flash[:error] = @user.errors.messages
      redirect to "/users/new"
    end
  end

  post '/users/login' do
    @user = find_user
    if authorized?
      login(@user.id) 
      redirect '/'
    else
      flash[:error] = "The provided login details were invalid. Have you signed up?"
      redirect "/users/new"
    end
  end

  get('/users/logout') {logout; redirect to "/"}

  get '/users/:slug' do
    @user = find_user_by_slug
    @title = @user.username
    erb :"/users/show"
  end

end




















