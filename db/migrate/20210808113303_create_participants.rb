class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.references :match
      t.references :member
      t.integer :score
      t.boolean :status

      t.timestamps
    end
  end
end
