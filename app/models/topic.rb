class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :topic_name , presence: true ,uniqueness: true
end
