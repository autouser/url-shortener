class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :url, limit: 255
      t.string :token, limit: 15
      t.timestamps
    end

    add_index :links, :token
  end
end
