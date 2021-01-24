class User < ActiveRecord::Base
  has_secure_password
  has_many :items
  has_many :packs

  validates :username, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
