class Ingredient < ActiveRecord::Base
  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients
  validates :name, uniqueness: { case_sensitive: false, message: "This Ingredient already exists. Please choose from the checkboxes." }
end
