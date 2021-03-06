class MoviesController < ApplicationController
    
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

#Thanks to Will Farmer for helping to condense code
def index
    #Array of all possible ratings (for our class)
    @all_ratings = ['G','PG','PG-13', 'R']

    #If sort_param is blank (nothing is "hilited"), use previous sorting method. Else use currently set sorting (param)
    session[:sort_by] = (params[:sort].blank? ? session[:sort_by] : params[:sort])

    #If sort_param is blank (nothing checked), repeast the last entry. Else use current set of checkboxes (param)
    session[:ratings] = (params[:ratings].blank? ? session[:ratings] : params[:ratings].keys)

    #Get all movies where rating (sort by ratings item), order within ratings by (sort_by) from 0-9/a-z
    @movies = Movie.where(:rating => session[:ratings]).order("#{session[:sort_by]} ASC")
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
