class AddCommentsCountToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :comments_count, :integer
  end
end
