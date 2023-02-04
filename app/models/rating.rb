class Rating < ApplicationRecord
  belongs_to :post
  #
  # after_save :save_avg
  #
  # def save_avg
  #   avg = Post.find(self.post_id).ratings.average(:post_rating)
  #   Post.find(self.post_id).update!(:rating_average=>avg)
  # end

end
