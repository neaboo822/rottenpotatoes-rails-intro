class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    if(params[:ratings].nil?) then
      @selected_ratings = @all_ratings
    else
      @selected_ratings = params[:ratings].keys
      #@selected_ratings ||= [ @all_ratings.map { |d| [d, 1] } ]
    end

    if params[:by] == 'title'
      @title_header = 'hilite'
      @movies = Movie.where(:rating => params[:r]).order(:title)
    elsif params[:by] == 'release_date'
      @release_date_header = 'hilite'
      @movies = Movie.where(:rating => params[:r]).order(:release_date)
    #@movies = Movie.find(:all, order: params[:by])
    else
      @movies = Movie.where(:rating => @selected_ratings)
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

end
