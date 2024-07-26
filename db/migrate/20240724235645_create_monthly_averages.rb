class CreateMonthlyAverages < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_averages do |t|
      t.date :date, null: false, index: true
      t.string :subject, null: false
      t.float :monthly_avg_low, default: 0
      t.float :monthly_avg_high, default: 0
      t.integer :monthly_result_count_used, default: 0
      t.float :total, default: 0

      t.timestamps
    end
  end
end
