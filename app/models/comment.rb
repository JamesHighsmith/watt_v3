class Comment < ActiveRecord::Base
  acts_as_voteable
  include ActsAsCommentable::Comment
  attr_accessible :title, :comment, :user_id, :commentable_id, :commentable_type
  belongs_to :commentable, :polymorphic => true
  acts_as_commentable
  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  

  # NOTE: Comments belong to a user
  belongs_to :user
  has_attached_file :image, styles: { medium: "320x240>"}

  def karma
    self.votes_for - self.votes_against
  end
end
