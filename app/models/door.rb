class Door < ActiveRecord::Base

	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
end
