class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.string :picture

      t.timestamps
    end
    add_index :images, [:user_id, :created_at]
  end
end
