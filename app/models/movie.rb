class Movie < ActiveRecord::Base
    
    def Movie.get_all_ratings
		all_ratings = []
		self.select(:rating).each do |movie|
			all_ratings << movie.rating
		end
		return all_ratings.uniq
    end
end
