class AddCounterColumnToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comments_count, :integer
    add_column :posts, :rating_average, :float
  end
end
