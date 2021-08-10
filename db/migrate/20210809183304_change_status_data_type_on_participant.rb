class ChangeStatusDataTypeOnParticipant < ActiveRecord::Migration[6.1]
  def change
    change_column :participants, :status, :int, :limit => 1
  end
end
