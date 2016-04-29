class Meal < ActiveRecord::Base
  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients
  # has_many :users, through: :meal_ingredients
  belongs_to :user
end
