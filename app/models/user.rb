class User < ActiveRecord::Base
  has_many :meals
  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients
  has_many :users, through: :meal_ingredients
end
