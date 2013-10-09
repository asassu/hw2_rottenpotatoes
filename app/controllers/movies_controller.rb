class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

   needToRedirect = false
    if params[:sort_by] == nil
      if session[:sort_by] != nil
        @sorted_field = session[:sort_by].to_s
        needToRedirect = true 
      end
    else
      @sorted_field = params[:sort_by].to_s
    end

    if @sorted_field != nil
      session.merge!({ :sort_by => @sorted_field })
    end 

    if needToRedirect == true
      newParams = Hash.new
      newParams.merge!({ :ratings => @checked_ratings_hash })
      newParams.merge!({ :sort_by => @sorted_field })
      redirect_to movies_path(newParams)
    end

	@movies = Movie.find_all_by_rating(@search_ratings, :order => @sorted_field)
	@highlight = @sorted_field
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
