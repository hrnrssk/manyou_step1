class ChangeDataPriorityToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :priority, 'integer USING CAST(priority AS integer)', null: false
  end
end
