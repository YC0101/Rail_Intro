class Movie < ActiveRecord::Base
  #Movie.all_ratings to return all possible values.
  def self.all_ratings
    self.select(:rating).distinct.map{|r| r.rating}
  end

  def self.with_ratings(ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # if ratings_list is nil, retrieve ALL movies
    if ratings_list.nil?
      Movie.all
    else
      Movie.where("rating in(?)", ratings_list)
    end
  end

end
