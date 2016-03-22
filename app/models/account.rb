class Account < ActiveRecord::Base
  validates_presence_of :insales_id
  validates_presence_of :insales_subdomain
  validates_presence_of :password

  def set_has_counter
  	self.update_attributes(has_counter: true)
  end

  def set_has_no_counter
  	self.update_attributes(has_counter: false)
  end
end
