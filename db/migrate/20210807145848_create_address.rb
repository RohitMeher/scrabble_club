class CreateAddress < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.text :address1
      t.text :address2
      t.string :address3
      t.string :post_code
      t.string :phone_number

      t.references :member
      t.timestamps
    end
  end
end
