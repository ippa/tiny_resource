class TinyResourceController < ApplicationController  
  require File.join(File.dirname(__FILE__), 'tiny_resource_helpers.rb')
  include TinyResourceHelpers
  helper_method :collection_url, :resource_url, :edit_resource_url, :new_resource_url
  helper_method :resource, :collection, :model
  
  def index
    self.collection = model.all
  end
  
  def show
    self.resource = model.find(params[:id])
  end
  
  def edit
    self.resource = model.find(params[:id])
    render "_form"
  end
  
  def update
    model.find_by_id(params[:id]).update_attributes(params[self.resource_name.to_sym])
    redirect_to :back
  end

  def new
    self.resource = model.new
    render "_form"
  end

  def create
    self.resource = model.new(params[resource_name.to_sym]).save
    redirect_to :back
  end

  def destroy
    model.find(params[:id]).destroy
    redirect_to collection_url
  end

end