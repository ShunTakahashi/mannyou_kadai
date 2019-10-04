class AddIndexTasksTitleContentStatus < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, [:title, :content, :status]
  end
end
