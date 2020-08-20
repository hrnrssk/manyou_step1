class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, unique: true
      t.text :detail, null: false

      t.timestamps
    end
  end
end
