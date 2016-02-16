require 'net/http'
require 'uri'

class MainController < ApplicationController
  def index
  end

  def installjs_post
  	code = params[:code]
  	Rails.logger.info(' code: ')
  	Rails.logger.info(code)
  	my_subdomain = @account.insales_subdomain
  	my_pass = @account.password
  	my_url = "http://" + my_subdomain + "/admin/js_tags.xml"
  	Rails.logger.info(' my_subdomain: ')
  	Rails.logger.info(my_subdomain)
  	Rails.logger.info(' my_pass: ')
  	Rails.logger.info(my_pass)
  	Rails.logger.info(' my_url: ')
  	Rails.logger.info(my_url)
	xml_data = %{<?xml version="1.0" encoding="UTF-8"?>
	  <js-tag>
		<type type="string">JsTag::FileTag</type>
		<content>http://www.busation.com/assets/application-22d02ec7221607ea6e60cfb943c49d0a.js</content>
	  </js-tag>}
	uri = URI.parse(my_url)
	request = Net::HTTP::Post.new uri.path
	Rails.logger.info(' Request body: ')
	request.body = xml_data
	Rails.logger.info(xml_data)
	request.content_type = 'text/xml'
	request.basic_auth 'id_detector', my_pass
	Rails.logger.info(' Request headers: ')
	Rails.logger.info(request.headers["Content-Type"])
	response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }
	Rails.logger.info(response.body)
	redirect_to '/installjs'
  end

  def installjs
  end
end
