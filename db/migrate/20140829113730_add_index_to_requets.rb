class AddIndexToRequets < ActiveRecord::Migration
  def change
    add_index :requests, :trap_name
  end
end
