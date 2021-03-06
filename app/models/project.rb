class Project < ActiveRecord::Base
  acts_as_taggable
  acts_as_commentable
  acts_as_voteable
  acts_as_gmappable
  attr_accessible :address, :idea, :problem, :solution, :user_id, :zipcode, :tag_list, :image, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?


  validates_attachment :image,# presence: true,
                               content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                               size: { less_than: 5.megabytes }

  belongs_to :user
  #default_scope -> { order(@project.karma) }
  has_attached_file :image #, styles: { medium: "320x240>"}

  validates :user_id, presence: true
  validates :idea, presence: true
  validates :problem, presence: true
  validates :solution, presence: true
  
  default_scope order: 'projects.created_at DESC'

  def karma
    self.votes_for - self.votes_against
  end
end
