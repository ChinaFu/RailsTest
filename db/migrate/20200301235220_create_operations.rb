class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.datetime :optime
      t.integer :pid

      t.timestamps
    end
  end
end
