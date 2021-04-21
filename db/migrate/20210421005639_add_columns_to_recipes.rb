class AddColumnsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :instructions, :string
    add_column :recipes, :completed, :boolean
  end
end
