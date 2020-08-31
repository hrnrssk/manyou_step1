class ChangeDataNameToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :name, :string, null: false, uniqueness: true
  end
end
