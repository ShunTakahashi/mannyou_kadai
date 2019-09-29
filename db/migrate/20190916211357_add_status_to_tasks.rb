class AddStatusToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :string, null: false, default: "not_yet_arrived"
  end
end


