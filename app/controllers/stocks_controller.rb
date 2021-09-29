class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |response|
          response.js {render partial: 'users/result'}
        end
      else
        respond_to do |response|
          flash.now[:alert] = 'please enter a valid stock or check the connection'
          response.js {render partial: 'users/result'}
        end
      end
    else
      respond_to do |response|
        flash.now[:alert] = "please enter a symbol to search"
        response.js {render partial: 'users/result'}
      end
    end

  end

end
