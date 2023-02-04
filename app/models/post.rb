class Post < ApplicationRecord

  self.per_page = 10

  has_and_belongs_to_many :users,:join_table => :posts_users_read_status
  belongs_to :topic
  belongs_to :user
  has_many :comments , dependent: :destroy
  has_many :ratings,after_add: :avg_rating,dependent: :destroy
  has_many :taggings , dependent: :destroy
  has_many :tags , through: :taggings
  accepts_nested_attributes_for :tags,reject_if: :reject_posts
  has_one_attached :post_image, dependent: :destroy

  validates :title,uniqueness: true, presence: true,length: {maximum: 20,too_long: "characters is the maximum %{count} allowed"}
  validates :body , presence: true
  def reject_posts(attributes)
    attributes['tag'].blank?
  end
    scope :ftr_post,->(start_date = Date.yesterday,end_date = Date.tomorrow) {
       if start_date.blank?
        where("created_at < ?",end_date.to_time)
      elsif end_date.blank?
        where("created_at > ?",start_date.to_time)
      else
      where("created_at between ? and ?",start_date,end_date)
       end
    }


  def avg_rating (pRating)
    rating  =self.ratings.average(:post_rating)
    # Post.find(post.post_id).update_columns(:rating_average=>rating)
    # puts post.inspect
    # self.update!(:rating_average=>rating)
    self.update_columns(:rating_average=>rating)
    puts self.id
  end
  # reject_if: proc { |attributes| attributes['tag'].blank? }, allow_destroy: true
end
