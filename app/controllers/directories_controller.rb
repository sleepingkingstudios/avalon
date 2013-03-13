class DirectoriesController < ApplicationController
  # GET (/:path)
  def show
    @directory = find_directory params[:path]
    
    redirect_to :root if @directory.nil?
  end # action show
  
  # GET (/:path)/directories
  def index
    @directory = find_directory params[:path]
  end # action index
  
  # GET (/:path)/directories/new
  def new
    @parent    = find_directory params[:path]
    @directory = Directory.new  params[:directory]
  end # action new
  
  # POST (/:path)/directories
  def create
    @parent    = find_directory params[:path]
    @directory = Directory.new params[:directory]
    @directory.parent = @parent
    
    if @directory.save
      redirect_to @directory.path
    else
      render :new
    end # if-else
  end # action create
  
  def find_directory path
    return nil if path.nil?
    
    Directory.find_by :path => "/#{path}"
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end # method find_directory
end # controller DirectoriesController
