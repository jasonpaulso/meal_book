class Meal < ActiveRecord::Base
  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients
  belongs_to :user
  validates_presence_of :name, message: "Your meal must have a name."
  validate :validate_ingredients
  def username
    self.user.username
  end
  def description
    "No description was provided." || self[:description]
  end


  def validate_ingredients
    errors.add(:ingredients, "Your meal must at least one ingredient.") if ingredients.size < 1
  end
end
