require 'net/http'
require 'uri'

class MainController < ApplicationController
  def index
  end

  def installjs
  	  my_app = self.current_app

	  # uri = URI.parse("http://busation.myinsales.ru/admin/js_tags.xml")
	  # req = Net::HTTP.new(uri.hostname, uri.port)
	  # xml_data = %{<?xml version="1.0" encoding="UTF-8"?>
	  # <js-tag>
   #  	<type type="string">JsTag::FileTag</type>
   #  	<content>http://busation.com/file.js</content>
	  # </js-tag>}
	  # base64user_and_pass = "4e95366ab96fe339e38123732ea08570"
	  # res = req.post(uri.path, xml_data, {'Content-Type' => 'text/xml', 'Content-Length' => xml_data.length.to_s, 'Authorization' => "Basic #{base64user_and_pass}", "Connection" => "keep-alive" })
	  # @res1 = res.body
	  @res1 = self.current_app
  end
end
