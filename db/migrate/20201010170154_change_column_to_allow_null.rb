class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :admin, true
  end
end
