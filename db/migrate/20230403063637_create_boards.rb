class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :email
      t.string :name
      t.string :rows
      t.string :columns
      t.string :mines
      t.boolean :playing, default: false
      t.json :board
      t.timestamps
    end
  end
end
