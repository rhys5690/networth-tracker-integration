class Account < ApplicationRecord
  belongs_to :user
  has_many :stocks, inverse_of: :account, dependent: :delete_all
  accepts_nested_attributes_for :stocks

  def get_stock_data
    @stock_name = stocks.first.stock_symbol.downcase
    response = HTTParty.get("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=#{@stock_name}&apikey=P220BS7L3ML520RS")
    response["Time Series (Daily)"].first.second["4. close"]
  end
end
