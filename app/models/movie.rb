class Movie < ActiveRecord::Base
    
    def Movie.get_all_ratings
		return self.select(:rating).uniq
    end
end
