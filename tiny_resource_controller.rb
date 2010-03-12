class TinyResourceController < ApplicationController  
  require File.join(File.dirname(__FILE__), 'tiny_resource_helpers.rb')
  include TinyResourceHelpers
  helper_method :collection_url, :resource_url, :edit_resource_url, :new_resource_url
  
  def index
    self.collection = self.model.all
  end
  
  def show
    self.resource = self.model.find(params[:id])
  end
  
  def edit
    self.resource = self.model.find(params[:id])
    render "_form"
  end
  
  def update
    model.find_by_id(params[:id]).update_attributes(params[self.resource_name.to_sym])
    redirect_to :back
  end

  def new
    self.resource = self.model.new
    render "_form"
  end

  def create
    self.resource = self.model.new(params[self.resource_name.to_sym]).save
    redirect_to :back
  end

  def destroy
    self.model.find(params[:id]).destroy
    #redirect_to "/"
    redirect_to collection_url
  end

end
