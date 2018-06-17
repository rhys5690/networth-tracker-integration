class AccountsController < ApplicationController
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
      values_to_input = ['72806279', 5690, 'rhys5690']
      a = Mechanize.new
      a.follow_meta_refresh = true
      a.redirect_ok = true
      a.get('https://ibanking.stgeorge.com.au/ibank/loginPage.action') do |page|
        my_page = page.form_with(action: 'logonActionSimple.action') do |f|
          used_fields = f.fields.select do |field|
            case field.type
            when 'text'
              true
            when 'password'
              true
            else
              false
            end
          end
          used_fields[0].value = values_to_input[0]
          used_fields[1].value = values_to_input[1]
          used_fields[2].value = values_to_input[2]
        end.click_button
        # example submitting log in form
        # my_page = page.form_with(action: '/account/login.php') do |f|
        #   f.form_loginname  = ARGV[0]
        #   f.form_pw         = ARGV[1]
        # end.click_button
        # example next action after submit
        # my_page.links.each do |link|
        #   text = link.text.strip
        #   next if text.empty?
        #   puts text
        # end
      end

      # delete if possible to do in merchanize
      #  doc = HTTParty.get("https://ibanking.stgeorge.com.au/ibank/loginPage.action")
      #  @parse_page ||= Nokogiri::HTML(doc)
      #  @access_number = @parse_page.css("#access-number")
      #  @security_number = @parse_page.css("#securityNumber")
      #  @internet_password = @parse_page.css("#internet-password")
      #  @parse_page.css("#internet-password")[0].attributes["id"].value
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
