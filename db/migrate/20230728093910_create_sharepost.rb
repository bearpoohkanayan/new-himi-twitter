class CreateSharepost < ActiveRecord::Migration[6.1]
  def change
    create_table :share_posts  do |t|
      t.references :user
      t.references :post
    end
  end
end
