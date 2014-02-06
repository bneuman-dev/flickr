class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  validates :title, :presence => true
  # Remember to create a migration!
end
