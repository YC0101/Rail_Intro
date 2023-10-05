class Movie < ActiveRecord::Base
  #Movie.all_ratings to return all possible values.
  def self.all_ratings
    return params[:ratings].to_a.uniq
  end

  def self.with_ratings(ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # if ratings_list is nil, retrieve ALL movies
    if ratings_list.nil?
      return Movie.all
    end
  end

end
