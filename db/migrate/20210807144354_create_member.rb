class CreateMember < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.date :join_date
      t.integer :matches_played, default: 0
      t.integer :wins, default: 0
      
      t.timestamps
    end
  end
end
