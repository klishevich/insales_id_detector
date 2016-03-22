class AdminController < ApplicationController
  skip_before_filter :authentication
  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      session[:authenticated] = username == ENV["http_basic_name"] && password == ENV["http_basic_pass"]
    end
  end

  def index
    @accounts=Account.all.reverse
    render layout: "admin_layout"
  end
end
