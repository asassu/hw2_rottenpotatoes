class MoviesController < ApplicationController
    
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

def index
    #Array of all possible ratings (for our class)
    @all_ratings = ['G','PG','PG-13', 'R']
    
    #NOTE TO SELF:
    #In a = a || b, a is set to something by the statement on every run, whereas with a || a = b, 
    #a is only set if a is logically false (i.e. if it's nil or false) because || is 'short circuiting'.
    #That is, if the left hand side of the || comparison is true, there's no need to check the right hand side.

    session[:sort_by] ||= 'title' #if item is selected the sort by that, else sort by title ("hilited" item)
    session[:ratings] ||= @all_ratings #if checkboxes are selected sort by that, else sort by all ratings

    session[:sort_by] = (params[:sort].blank? ? session[:sort_by] : params[:sort]) # if sort_param is blank, sort by previous, else by param
    session[:ratings] = (params[:ratings].blank? ? session[:ratings] : params[:ratings].keys) # if filter is blank, filter by previous, else by param

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
