module MealHelpers
  def all_meals
    @meals = Meal.all
  end

  def find_meal
    if !!Meal.find(params[:id])
      Meal.find(params[:id])
    end
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
    if !params[:ingredients].nil?
      params[:ingredients]["text_area"].reject! {|v| v.empty?}
    end
    if params[:ingredient]["text_area"] != nil
      @ingredients = params[:ingredient]["text_area"].split("\r\n")
      @ingredients.each do |ingredient|
        @meal.ingredients << Ingredient.find_or_create_by(name: ingredient)
      end
    else
      @ingredients.each do |ingredient|
        @meal.ingredients << Ingredient.find_or_create_by(name: ingredient) 
      end
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
    @new_meal.name = @meal.name + ": copied by #{current_username}"
    @new_meal.save
    @new_meal
  end
end

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
    @user
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

    if User.find_by_slug(params[:slug]) != nil
      User.find_by_slug(params[:slug])
    else
      redirect to "/"
    end
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