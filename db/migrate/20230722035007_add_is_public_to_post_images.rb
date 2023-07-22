class AddIsPublicToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :is_public, :boolean, default: true
  end
end
