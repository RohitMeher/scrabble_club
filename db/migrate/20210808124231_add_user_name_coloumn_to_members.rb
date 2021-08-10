class AddUserNameColoumnToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :user_name, :string
  end
end
