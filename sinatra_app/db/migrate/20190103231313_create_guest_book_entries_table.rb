class CreateGuestBookEntriesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :guest_book_entries do |t|
      t.string :name
      t.string :comment
      t.timestamps
    end
  end
end
