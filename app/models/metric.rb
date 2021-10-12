class Metric < ApplicationRecord
  validates :name, uniqueness: true
end
