class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_and_belongs_to_many :posts, :join_table => :posts_users_read_status
  has_one :post
  has_one :comment

  has_many :user_comment_ratings, :dependent => :destroy
  has_many :comments , through: :user_comment_ratings
  devise :database_authenticatable, :registerable,:lockable,
         :recoverable, :rememberable, :validatable,:trackable,
         :timeoutable, timeout_in: 15.minutes

  after_create :welcome_email

  def welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

end
