class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def already_tracked(ticker)
    stock = Stock.check_db(ticker)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end
  def track_limit
    stocks.count < 10
  end
  def can_track(ticker)
    return track_limit && !already_tracked(ticker)
  end
  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
  def self.first_name_matches(param)
    matches('first_name', param)
  end
  def self.last_name_matches(param)
      matches('last_name', param)
  end
  def self.email_matches(param)
      matches('email', param)
  end
  def self.search(param)
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end
  def except_current_user(users)
    users.reject {|user| user.id == self.id}
  end
  def self.matches(field, param)
    where("#{field} like ?", "%#{param}%")
  end
  def not_friends_with(user)
    !self.friends.where(id: user).exists?
  end
end
