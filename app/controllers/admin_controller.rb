class AdminController < ApplicationController
  skip_before_filter :authentication, :configure_api
  before_filter :authenticate

  def authenticate
    Rails.logger.info(' http_basic_name: ')
    Rails.logger.info(ENV["http_basic_name"])
    Rails.logger.info(ENV["http_basic_pass"])
    authenticate_or_request_with_http_basic do |username, password|
      session[:authenticated] = username == ENV["http_basic_name"] && password == ENV["http_basic_pass"]
    end
  end

  def index
    @accounts=Account.all.reverse
    render layout: "admin_layout"
  end
end
