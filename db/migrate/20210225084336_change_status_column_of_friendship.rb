class ChangeStatusColumnOfFriendship < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :status, :integer, using: 'status::integer'
  end
end
