class Pack < ActiveRecord::Base
  has_many :items
  belongs_to :user

  def slug
    self.trip_name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Pack.all.find{|pack| pack.slug == slug}
  end

end
