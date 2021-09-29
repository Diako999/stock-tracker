class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
      @user_stock = UserStock.create(user: current_user, stock: stock)
      flash[:notice] = "stock #{stock.name} saved..."
      redirect_to my_portfolio_path
    end
  end
  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user: current_user, stock: stock).first
    user_stock.destroy
    flash[:notice] = "stock untracked successfulyl :)"
    redirect_to my_portfolio_path
  end
end
