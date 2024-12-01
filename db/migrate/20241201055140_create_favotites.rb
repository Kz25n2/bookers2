class CreateFavotites < ActiveRecord::Migration[6.1]
  def change
    create_table :favotites do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
