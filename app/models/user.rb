class User < ActiveRecord::Base
  validates_presence_of :username, :password
  has_secure_password
  has_many :meals
  has_many :meal_ingredients
  has_many :ingredients, through: :meal_ingredients
  has_many :users, through: :meal_ingredients
  validates :username, uniqueness: { case_sensitive: true }

  def slug
    self.username.downcase.slug!
  end

  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug}
  end
end
