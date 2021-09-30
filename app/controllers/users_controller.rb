class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @stocks = current_user.stocks
  end
  def my_friends
    @friends = current_user.friends
  end
  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |response|
          response.js {render partial: 'users/friend_result'}
        end
      else
        respond_to do |response|
          flash.now[:alert] = 'couldn`t find user'
          response.js {render partial: 'users/friend_result'}
        end
      end
    else
      respond_to do |response|
        flash.now[:alert] = "please enter a name or an email to search"
        response.js {render partial: 'users/friend_result'}
      end
    end
  end
  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks
  end

end
