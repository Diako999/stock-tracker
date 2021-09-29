class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def already_tracked(ticker)
    stock = Stock.check_db(ticker)
    return true if stock
    # stocks.where(id: stock.id).exists?
  end
  def track_limit
    stocks.count < 10
  end
  def can_track(ticker)
    track_limit && !already_tracked(ticker)
  end
end
