class DailyResultStat < ApplicationRecord
  validates_uniqueness_of :date, scope: [:subject]
end
