class Meal < ActiveRecord::Base
  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients
  belongs_to :user
  validates_presence_of :name, message: "Your meal must have a name."
  validates :ingredients, :length => { :minimum => 1, message: "Your meal must at least one ingredient." }
  def username
    self.user.username
  end
end
