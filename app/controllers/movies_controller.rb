class MoviesController < ApplicationController
  #Part 1 Requirment 1
  def initialize
    @all_ratings = Movie.all_ratings
    #@ratings_to_show = Array.new()
    super
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #ratings
    if params[:ratings]
      @ratings_to_show = params[:ratings]
    else
      @ratings_to_show = @all_ratings.map{|r| [r,1]}.to_h
    end

    if session[:ratings]
      @ratings_to_show = session[:ratings]
    end

    #sort
    if params[:sort]
      @sort = params[:sort]
    else
      if session[:sort] 
        @sort = session[:sort]
      else
        @sort = ''
        session[:sort] = ''
      end
    end

    if @sort == '' 
      @movies = Movie.with_ratings @ratings_to_show.keys
    else
      @movies = Movie.with_ratings(@ratings_to_show.keys).order(@sort + ' asc')
    end
    #@movies = Movie.all

    if !(params.has_key?(:ratings) && params.has_key?(:sort))
      redirect_to movies_path(:ratings=>@ratings_to_show,:sort=>@sort)
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
