class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :posts , through: :taggings
  validates :tag, presence: true, uniqueness: true
end
