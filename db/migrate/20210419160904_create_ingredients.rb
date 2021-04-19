class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.belongs_to :food, null: false, foreign_key: true
      t.string :amount

      t.timestamps
    end
  end
end
