class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :detail, presence: true, length: { maximum: 200 }
end
