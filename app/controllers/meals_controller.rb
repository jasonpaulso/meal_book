class MealsController < ApplicationController

    module MealHelpers
    def all_meals
      @meals = Meal.all
    end

    def find_meal
        Meal.find(params[:id])
    end

    def new_meal
      @meal = Meal.create(params[:meal])
      @meal.description = "No description provided." if params[:meal][:description] == ""
      current_user.meals << @meal
      update_or_add_ingredients
      @meal
    end
    def update_meal
      @meal.update(params[:meal])
      update_or_add_ingredients
      @meal.save
    end
    
    def update_or_add_ingredients
      @ingredients = params[:ingredient]["text_area"].split("\r\n")
      @ingredients.each do |ingredient|
        @meal.ingredients << Ingredient.find_or_create_by(name: ingredient.downcase) 
      end
    end

    def editable?
      @meal.user.id == current_user.id && logged_in?
    end

    def meals_empty?
      Meal.all.empty?
    end

    def duplicate_meal
      @meal = find_meal
      @new_meal = @meal.deep_clone include: :ingredients
      @new_meal.user_id = current_user.id
      @new_meal.name = @meal.name + " (duplicated by #{current_username})"
      @new_meal.save
      @new_meal
    end
  end

  before do
    set_title
  end

  get '/meals/new' do
    if logged_in?
      @title = "MealPost"
      erb :"/meals/new"
    else
      redirect "/"
    end
  end

  get '/meals/index' do 
    @title = "MealFeed"
    if meals_empty?
      redirect '/meals/new'
    else
      erb :"/meals/index"
    end
  end

  get '/meals/:id/edit' do
    @meal = find_meal
    @title = "Edit Meal"
    if editable?
        erb :"/meals/edit"
    else
      erb :"/meals/error"
    end
  end

  get '/meals/:id' do 
    @meal = find_meal
      @title = "#{@meal.name} by #{@meal.username}"
      erb :"/meals/show"
  end

  post "/meals" do 
    @meal = new_meal
    redirect to "/meals/#{@meal.id}"
  end

  patch '/meals/:id' do
    @meal = find_meal
    update_meal
    redirect "/meals/#{@meal.id}"
  end

  delete '/meals/:id/delete' do
    @meal = find_meal
    @meal.destroy
    redirect to '/meals/index'
  end

  get '/meals/:id/duplicate' do
    @meal = duplicate_meal
    redirect to "/meals/#{@meal.id}/edit"
  end

end






