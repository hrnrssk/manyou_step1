class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :detail, presence: true, length: { maximum: 200 }
  validates :deadline, presence: true, length: { maximum: 30 }
  validates :status, presence: true, length: { maximum: 30 }
  validates :priority, presence: true, length: { maximum: 30 }
  validates :author, presence: true, length: { maximum: 30 }
  enum status:{
    未着手: 0,
    着手中: 1,
    完了: 2
  }
end
