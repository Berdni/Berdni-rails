class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :post, dependent: :destroy

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    puts auth_hash
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      name: auth_hash.info.name,
      avatar: auth_hash.extra.raw_info.photo_400_orig
    )
    user
  end

  def remember
    self.remember_token = new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def new_token
    SecureRandom.urlsafe_base64
  end
end
