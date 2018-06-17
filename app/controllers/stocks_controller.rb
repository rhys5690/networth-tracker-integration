class StocksController < ApplicationController
  def create
  end

  private

   def stock_params
     params.require(:stock).permit(:stock_symbol, :date_purchased, :amount_purchased)
   end
end
