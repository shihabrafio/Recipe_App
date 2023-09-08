
class CreateRecipeFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_foods do |t|
      # Define your table columns here
      t.integer :food_id
      t.integer :recipe_id
      t.integer :quantity
      t.timestamps
    end
  end
end
