class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text     :state
      t.text     :task
      t.date     :limit_date
      t.text     :free_comment
      t.integer  :user_id

      t.timestamps
    end
  end
end
