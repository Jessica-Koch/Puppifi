class RemoveDogColumn < ActiveRecord::Migration
  def change
    remove_column :users, :dog_id, :integer
  end
end
