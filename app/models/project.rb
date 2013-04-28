class Project < ActiveRecord::Base
  acts_as_commentable
  acts_as_voteable
  attr_accessible :address, :idea, :problem, :solution, :user_id, :zipcode
  belongs_to :user

  validates :user_id, presence: true
  validates :idea, presence: true
  validates :problem, presence: true
  validates :solution, presence: true
  
  default_scope order: 'projects.created_at DESC'

end
