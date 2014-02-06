class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :filename
      t.string :title
      t.string :description
      t.integer :album_id
      t.timestamps
    end
  end
end
