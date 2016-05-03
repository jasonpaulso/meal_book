class AddDescriptionColumnToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :description, :text
  end
end
