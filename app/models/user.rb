# good
# frozen_string_literal: true

# Some documentation for Person
class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :downcase_email
  before_create :create_activation_digest
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:
                                      :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:
                                      :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save { email.downcase }   # Dam bao tinh only

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # Returns the hash digest of the given string. Trả về thông báo băm của chuỗi đã cho.
  class << self
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost:)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  # Ghi nhớ một người dùng trong cơ sở dữ liệu để sử dụng trong các phiên liên tục.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end
  # Returns true if the given token matches the digest.
  ## Trả về true nếu mã thông báo đã cho khớp với thông báo.

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def session_token
    remember_digest || remember
  end
  # Activates an account.
  # Kích hoạt tài khoản.

  def activate
    update_columns(activated: FILL_IN, activated_at: FILL_IN)
  end
  # Sends activation email.
  # Gửi email kích hoạt.

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  # gui gmail
  # Activates an account.
  # Kích hoạt tài khoản.

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
  # Sets the password reset attributes.
  # Đặt thuộc tính đặt lại mật khẩu.

  def create_reset_digest
    self.reset_token = User.new_token
    # update_attribute(:reset_digest, User.digest(reset_token))
    # update_attribute(:reset_sent_at, Time.zone.now)
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  # Returns true if a password reset has expired.
  # Trả về true nếu quá trình đặt lại mật khẩu đã hết hạn.

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    # Micropost.where("user_id = ?", id)
    # Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)

    #  following_ids = "SELECT followed_id FROM relationships Nguyen trong Nghia
    #  WHERE follower_id = :user_id"
    #  Micropost.where("user_id IN (:following_ids) OR user_id = :user_id",
    #  following_ids: following_ids, user_id: id)

    part_of_feed = 'relationships.follower_id = :id or microposts.user_id = :id'
    Micropost.left_outer_joins(user: :followers).where(part_of_feed, { id: })
  end

  # Chuong 14
  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  private

  # Converts email to all lower-case.
  ## Chuyển đổi email thành tất cả các chữ thường.

  def downcase_email
    self.email = email.downcase
  end
  # Creates and assigns the activation token and digest.
  # Tạo và chỉ định mã thông báo kích hoạt và thông báo.

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
