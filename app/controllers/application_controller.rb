class ApplicationController < Sinatra::Base
  helpers MealsController::MealHelpers
  helpers UsersController::UserHelpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_supper"
  end

  helpers do 
    def set_title
      @title ||= "MealBook"
    end
  end

  before do
    set_title
  end

  get('/') {@title = "Home"; erb :index}

end