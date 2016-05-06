class User < ActiveRecord::Base
  validates_presence_of :username, message: "You must create a username"
  validates :username, uniqueness: { case_sensitive: false,  message: "This username has already been taken." }
  validates_presence_of :password, message: "You must create a password"
  has_secure_password validations: false
  has_many :meals
  

  def slug
    self.username.downcase.slug!
  end

  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug.downcase}
  end

end
