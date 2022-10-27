class DressesController < ApplicationController

  def show
    id = params[:id] # retrieve dress ID from URI route
    @dress = Dress.find(id) # look up dress by unique ID
    # will render app/views/dresses/show.<extension> by default
  end

  def index
    @dresses = Dress.all
  end

  def search
    if params[:search].blank?
      redirect_to dresses_path and return
    else
      @parameter = params[:search].downcase
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @dress = Dress.create!(dress_params)
    flash[:notice] = "#{@dress.title} was successfully created."
    redirect_to dresses_path
  end

  def edit
    @dress = Dress.find params[:id]
  end

  def update
    @dress = Dress.find params[:id]
    @dress.update_attributes!(dress_params)
    flash[:notice] = "#{@dress.title} was successfully updated."
    redirect_to dress_path(@dress)
  end

  def destroy
    @dress = Dress.find(params[:id])
    @dress.destroy
    flash[:notice] = "Dress '#{@dress.title}' deleted."
    redirect_to dresses_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def dress_params
    params.require(:dress).permit(:title, :rating, :description, :release_date)
  end
end
