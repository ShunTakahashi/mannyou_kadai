class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :label_tasks, through: :labelings, source: :task
end
