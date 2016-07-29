class Meshi < ActiveRecord::Migration
  def up
    create_table :tweets do |t|
      t.string  :contents
      t.string :url
      t.timestamps
    end
  end

  def down
    drop_table :tweets
  end
end
