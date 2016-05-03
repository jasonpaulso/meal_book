class Ingredient < ActiveRecord::Base
  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients
  validates :name, uniqueness: { case_sensitive: false }
  validates_length_of :name, minimum: 3
end
