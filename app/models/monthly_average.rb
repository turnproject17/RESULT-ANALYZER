class MonthlyAverage < ApplicationRecord
  validates_uniqueness_of :date, scope: [:subject]
end
