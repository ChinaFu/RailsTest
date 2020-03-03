class CreateNetPackets < ActiveRecord::Migration[5.2]
  def change
    create_table :net_packets do |t|
      t.datetime :starttime
      t.datetime :stoptime
      t.text :srcip
      t.integer :srcport
      t.text :dstip
      t.integer :dstport
      t.integer :packets

      t.timestamps
    end
  end
end
