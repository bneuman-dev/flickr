class Photo < ActiveRecord::Base
  belongs_to :album
  validates :title, :presence => true
  validates :filename, :presence => true

  def user
    self.album.user
  end
  # Remember to create a migration!
end
