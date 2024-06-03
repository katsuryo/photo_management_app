class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
