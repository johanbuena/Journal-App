class CreateJournals < ActiveRecord::Migration[6.1]
  def change
    create_table :journals do |t|
      t.integer :user_id
      t.text :journal_name
      t.text :journal_description

      t.timestamps
    end
  end
end
