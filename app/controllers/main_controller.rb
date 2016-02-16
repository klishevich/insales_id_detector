require 'net/http'
require 'uri'

class MainController < ApplicationController
  def index
  end

  def installjs
  	  my_subdomain = @account.insales_subdomain
  	  my_pass = @account.password
  	  my_url = "http://" + my_subdomain + "/admin/js_tags.xml"
  	  Rails.logger.info(' my_subdomain: ')
  	  Rails.logger.info(my_subdomain)
  	  Rails.logger.info(' my_pass: ')
  	  Rails.logger.info(my_pass)
  	  Rails.logger.info(' my_url: ')
  	  Rails.logger.info(my_url)
	  uri = URI.parse(my_url)
	  req = Net::HTTP.new(uri.hostname, uri.port)
	  xml_data = %{<?xml version="1.0" encoding="UTF-8"?>
	  <js-tag>
    	<type type="string">JsTag::FileTag</type>
    	<content>http://www.busation.com/assets/application-22d02ec7221607ea6e60cfb943c49d0a.js</content>
	  </js-tag>}
	  res = req.post(uri.path, xml_data, {'Content-Type' => 'text/xml', 'Content-Length' => xml_data.length.to_s, 'Authorization' => "Basic #{my_pass}", "Connection" => "keep-alive" })
  end
end
