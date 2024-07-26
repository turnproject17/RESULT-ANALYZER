class CreateDailyResultStats < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_result_stats do |t|
      t.date :date, null: false, index: true
      t.string :subject, null: false
      t.float :daily_high, default: 0
      t.float :daily_low, default: 0
      t.float :total, default: 0
      t.integer :result_count, default: 0

      t.timestamps
    end
  end
end
