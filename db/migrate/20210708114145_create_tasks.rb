class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :journal_id
      t.text :taskname
      t.text :taskdescription
      t.date :taskdeadline
      t.boolean :taskstatus #false = pending | true = completed

      t.timestamps
    end
  end
end
