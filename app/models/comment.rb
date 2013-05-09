class Comment < ActiveRecord::Base
  acts_as_voteable
  include ActsAsCommentable::Comment
  attr_accessible :title, :comment, :user_id, :commentable_id, :commentable_type, :image
  belongs_to :commentable, :polymorphic => true
  acts_as_commentable
  default_scope -> { order('created_at DESC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # this is causing trouble with posting comment without image attachment, but we don't need to have an image attached. 
    validates_attachment :image,
                                content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                                size: { less_than: 5.megabytes }

  # NOTE: Comments belong to a user
  belongs_to :user
  has_attached_file :image,
  :styles => {
    :tiny => "25x25#",
    :thumbnail => "100x100#",
    :small  => "150x150>",
    :medium => "300x300>" },
    :default_url => "/images/default_:style.png"

  def karma
    self.votes_for - self.votes_against
  end
end
