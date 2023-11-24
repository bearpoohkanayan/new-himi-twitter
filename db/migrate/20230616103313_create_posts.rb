class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts  do |t|
      t.string :contents
      t.integer :yaba
      t.timestamps null: false
      t.references :user
    end
  end
end
