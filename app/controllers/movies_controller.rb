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
    @all_ratings = Movie.get_all_ratings
    if !params.has_key?(:sort) && !params.has_key?(:ratings)
      if(session.has_key?(:sort) || session.has_key?(:ratings))
        redirect_to movies_path(:sort=>session[:sort], :ratings=>session[:ratings])
      end
      if !session.has_key?(:ratings)
        @ratings = @all_ratings
        session[:ratings] = @ratings
      end
    end
    if params.has_key?(:sort)
      @sort = params[:sort]
      session[:sort] = @sort
    end
    if params.has_key?(:ratings)
      @ratings = params[:ratings].keys
      session[:ratings] = @ratings
    end
    
    @ratings = session[:ratings]
    if session.has_key?(:sort)
      @sort = session[:sort]
      if @sort == "title"
        @title_header = "hilite"
      elsif @sort == "release_date"
        @release_date_header = "hilite"
      end
      @movies = Movie.order(@sort).where({rating: @ratings})
    else
      @movies = Movie.where({rating: @ratings})
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
