class Movie < ActiveRecord::Base
    
    def Movie.get_all_ratings
		all_ratings = []
		self.select(:rating).unique.each do |mo|
			all_ratings << mo.rating
		end
		return all_ratings
    end
end
