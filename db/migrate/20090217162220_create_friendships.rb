class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.column :user_id, :integer
      t.column :friend_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
