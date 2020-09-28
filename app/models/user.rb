class User < ApplicationRecord
  validates :user_name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy

  before_destroy :must_not_destroy_last_one_user

  # def must_not_destroy_last_one_user
  #   if User.where(admin: true).count == 1 && self.admin
  #     errors.add :base, '少なくとも1つ、ログイン用の認証が必要です'
  #     throw :abort
  #   end
  # end

  def must_not_destroy_last_one_user
    if User.where(admin: true).count == 1 && self.admin
      throw :abort
    end
  end
end
