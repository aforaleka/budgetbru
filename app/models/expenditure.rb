class Expenditure < ActiveRecord::Base
	validates :price, :quantity, :name, :purchase_date, presence: true
	belongs_to :user
end
