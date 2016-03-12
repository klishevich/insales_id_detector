require 'net/http'
require 'uri'
require 'base64'

class MainController < ApplicationController
  def index
  end

  def installjs_post
  	code = params[:code]
   	Rails.logger.info(' code: ')
  	Rails.logger.info(code)
  	code_doc = Nokogiri::XML(code)
  	# src_value = code_doc.xpath('//noindex/script/@src').first.value
 #  	src_value = ""
 #  	code_doc.css("script").each do |node|
 #  		src_value = node["src"]
	# end
	  src_value = code_doc.xpath('//noindex').first.children.last.to_s
  	Rails.logger.info(' src_value: ')
  	Rails.logger.info(src_value)
  	str_index = src_value.index('base64')
  	Rails.logger.info(' str_index: ')
  	Rails.logger.info(str_index)
  	src_value2 = src_value[str_index+7..-6]
  	Rails.logger.info(' src_value2: ')
  	Rails.logger.info(src_value2)
  	src_value3 = Base64.decode64(src_value2)
   	Rails.logger.info(' src_value3: ')
  	Rails.logger.info(src_value3)
    file_name = "id"+Time.now.strftime("%Y%m%d%H%M")+".js"
    file = File.join(Rails.root, 'public', 'system', 'file_name')
    Rails.logger.info(' file: ')
    Rails.logger.info(file)
    output = File.open( file, "w" )
    output << src_value3
    output.close

  	# esc_code = src_value3.encode(:xml => :attr)
  	# Rails.logger.info(' esc_code: ')
  	# Rails.logger.info(esc_code)
  	my_subdomain = @account.insales_subdomain
  	my_pass = @account.password
  	my_url = "http://" + my_subdomain + "/admin/js_tags.xml"
  	Rails.logger.info(' my_subdomain: ')
  	Rails.logger.info(my_subdomain)
  	Rails.logger.info(' my_pass: ')
  	Rails.logger.info(my_pass)
  	Rails.logger.info(' my_url: ')
  	Rails.logger.info(my_url)

    js_file_url = "http://id-detector.j123.ru/system/" + file_name
    Rails.logger.info(' js_file_url: ')
    Rails.logger.info(js_file_url)

	  xml_data = %{<?xml version="1.0" encoding="UTF-8"?>
	    <js-tag>
		  <type type="string">JsTag::FileTag</type>
		  <content>} + src_value3 + %{</content>
	    </js-tag>}
	  uri = URI.parse(my_url)
	  request = Net::HTTP::Post.new uri.path
	  Rails.logger.info(' Request body: ')
	  request.body = xml_data
	  Rails.logger.info(xml_data)
	  request.content_type = 'text/xml'
	  request.basic_auth 'id_detector', my_pass
	  response = Net::HTTP.new(uri.host, uri.port).start { |http| http.request request }
	  Rails.logger.info( 'response body:' )
	  Rails.logger.info(response.body)
	  redirect_to '/installjs'
  end

  def installjs
  end
end
