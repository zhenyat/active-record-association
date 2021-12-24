class CreateAuthorsPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :authors_posts do |t|
      t.references :author, null: false, foreign_key: true
      t.references :post,   null: false, foreign_key: true
    end
  end
end
