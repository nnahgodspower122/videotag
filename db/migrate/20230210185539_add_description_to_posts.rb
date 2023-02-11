class AddDescriptionToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :description, :text
  end
end
