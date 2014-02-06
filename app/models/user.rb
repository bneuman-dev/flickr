class User < ActiveRecord::Base
  has_many :albums
  has_many :photos, through: :albums
  validates :username, :presence => true
  validates :password, :presence => true
  validates :username, :uniqueness => true

  def self.authenticate(username, password)
    user = self.find_by(username: username)
    return user if user && (user.password == password)
    nil
  end



  # Remember to create a migration!
end
