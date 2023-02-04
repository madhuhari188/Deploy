class UserCommentRating < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  validates :comment_id, uniqueness: { scope: [:user],message: "Already Reviewed" }
end