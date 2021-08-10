class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.date :start_date
      t.text :venue
      
      t.timestamps
    end
  end
end
