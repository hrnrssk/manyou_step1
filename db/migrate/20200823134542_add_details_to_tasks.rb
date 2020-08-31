class AddDetailsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :string, null: false
    add_column :tasks, :status, :string, null: false
    add_column :tasks, :priority, :string, null: false
    add_column :tasks, :author, :string, null: false
  end
end
