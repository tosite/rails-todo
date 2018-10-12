class User < ApplicationRecord
  has_many :tasks
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates:name,     presence: true, length: { maximum: 20 }
  validates:email,    presence: true, length: { maximum: 255 }, 
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
                      validates:password, presence: true, length: { minimum: 8 }
  has_secure_password

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

end
