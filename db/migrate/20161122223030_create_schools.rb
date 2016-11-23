class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.integer :students
      t.boolean :open

      t.timestamps
    end
  end
end
