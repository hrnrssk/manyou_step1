class ChangeDataUniquenameToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :name, :string, null: false, unique: true
  end
end
