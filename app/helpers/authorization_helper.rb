module AuthorizationHelper
	def can_edit_expenditure?(expenditure)
		expenditure.user == current_user
	end
	
end
