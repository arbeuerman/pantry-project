class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :meal
      t.string :cuisine

      t.timestamps
    end
  end
end
