class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.datetime :timestamp, null: false, index: 0
      t.string :subject, null: false, index: 0
      t.float :marks, default: 0

      t.timestamps
    end
  end
end
