class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.attachment :avatar
      t.integer :dog_id
    end
  end
end
