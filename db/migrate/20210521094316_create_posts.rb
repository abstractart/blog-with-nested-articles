class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :slug, limit: 128, null: false, index: { unique: true }
      t.string :parent_slug, limit: 128, null: true
      t.jsonb :toc_settings, null: false, default: {}

      t.string :title, null: false, limit: 128
      t.text :content, null: false, default: ''
      t.boolean :published, null: false, default: false

      t.timestamps
    end

    add_index :posts, [:parent_slug, :slug]
    add_foreign_key :posts, :posts, column: :parent_slug, primary_key: :slug
  end
end
