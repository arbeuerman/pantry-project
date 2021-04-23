class AddColumnsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :instructions, :string
    add_column :recipes, :completed, :boolean
    add_column :recipes, :api_id, :integer
    add_column :recipes, :image_url, :string
  end
end
