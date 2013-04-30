class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  acts_as_voter
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many  :projects,  dependent: :destroy
  # attr_accessible :title, :body
  has_many :comments

  def name
    self.first_name + ' ' + self.last_name.first.capitalize + "."
  end

  def karma
    self.projects.sum {|project| project.votes_for} + self.comments.sum {|comment| comment.votes_for}
  end

end
