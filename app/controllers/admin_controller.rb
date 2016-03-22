class AdminController < ApplicationController
  skip_before_filter :authentication, :configure_api
  before_filter :authenticate

  def authenticate
    Rails.logger.info(' http_basic_name: ')
    Rails.logger.info(Figaro.env.http_basic_name)
    Rails.logger.info(Figaro.env.http_basic_pass)
    authenticate_or_request_with_http_basic do |username, password|
      session[:authenticated] = username == Figaro.env.http_basic_name && password == Figaro.env.http_basic_pass
    end
  end

  def index
    @accounts=Account.all.reverse
    render layout: "admin_layout"
  end
end
