class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :detail, presence: true, length: { maximum: 200 }
  validates :deadline, presence: true, length: { maximum: 30 }
  validates :status, presence: true, length: { maximum: 30 }
  validates :priority, presence: true, length: { maximum: 30 }
  validates :author, presence: true, length: { maximum: 30 }

  scope :search_with_name, -> (search_params) { where(['name LIKE ?', "%#{ search_params }%"]) }
  scope :search_with_status, -> (search_params) { where(['status = ?', "#{ search_params }"]) }
  scope :search_with_name_and_status, -> (name, status) { where(['name LIKE ? and status = ?', "%#{ name }%", "#{ status }"])}

  enum priority:{ '高': 1, '中': 2, '低': 3 }
end
