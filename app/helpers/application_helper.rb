module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title = '')
		suffix = "Rails App"
		if(page_title) 
			if(page_title.empty?)
				suffix
			else
				page_title + "|" + suffix
			end
		else
			suffix
		end	
	end

end
