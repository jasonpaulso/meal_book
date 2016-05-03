class Meal < ActiveRecord::Base
  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients
  belongs_to :user
  validates_length_of :name, minimum: 4
  validates :name, uniqueness: { case_sensitive: false }

  def username
    self.user.username
  end
end
