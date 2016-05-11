module MealHelpers
  def all_meals
    @meals = Meal.all
  end

  def find_meal
    if !!Meal.find(params[:id])
      Meal.find(params[:id])
    end
  end

  def update_or_add_ingredients
    if !params[:ingredients].nil?
      params[:ingredients]["text_area"].reject! {|v| v.empty?}
    end
    if params[:ingredient]["text_area"] != "" || params[:ingredient]["text_area"] != nil
      @ingredients = params[:ingredient]["text_area"].split("\r\n")
      @ingredients.each do |ingredient|
        if Ingredient.find_by(name: ingredient)
          @meal.ingredients << Ingredient.find_by(name: ingredient)
        else
          @meal.ingredients << Ingredient.create(name: ingredient)
        end
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
    @user && @user.authenticate(params[:password])
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