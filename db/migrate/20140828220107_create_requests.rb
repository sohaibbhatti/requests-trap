class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :trap_name, null: false
      t.hstore :data, null: false

      t.timestamps
    end
  end
end
