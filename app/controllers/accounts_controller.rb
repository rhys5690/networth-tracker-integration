class AccountsController < ApplicationController

  require 'capybara/poltergeist'
  def new
    if Account.where(user_id: current_user.id).first
      @account_exists = true
      redirect_to root_path
    else
      @account_exists = false
      @account = Account.new
      @account.stocks.build
    end
  end

  def edit
    @account = Account.where(id: params[:id]).first
  end

  def update
    @account = Account.where(id: params[:id]).first
    if @account.update_attributes(account_params)
      # test
      redirect_to root_path
    else
      # render the edit form again
    end
  end

  def create
    @account = current_user.accounts.create(account_params)
    redirect_to root_path if @account.save
  end

  def show
    if Account.where(user_id: current_user.id).first
      @account = Account.where(user_id: current_user.id).first

      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, js_errors: false)
      end

      # Configure Capybara to use Poltergeist as the driver
      Capybara.default_driver = :poltergeist

      session = Capybara::Session.new(:poltergeist)

      session.visit('https://ibanking.stgeorge.com.au/ibank/loginPage.action')
      session.fill_in 'access-number', with: '72806279'
      session.fill_in 'securityNumber', with: '5690'
      session.fill_in 'internet-password', with: 'rhys5690'
      session.click_on 'Logon'
      session.click_on 'Express Freedom'
      session.click_link 'transHistExport'

      byebug
      @networth_total = 35_000
      @account_exists = true
    else
      redirect_to new_account_path
    end
  end

  private

  def account_params
    params.require(:account).permit(:access_number, :security_number, :internet_password)
  end
end
