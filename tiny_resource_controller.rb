class TinyResourceController < ApplicationController  
  require File.join(File.dirname(__FILE__), 'tiny_resource_helpers.rb')
  include TinyResourceHelpers
  helper_method :collection_url, :resource_url, :edit_resource_url, :new_resource_url
  helper_method :collection_path, :resource_path, :edit_resource_path, :new_resource_path
  helper_method :resource, :collection, :model
  
  def index
    self.collection = model.all
  end
  
  def show
    self.resource = find_resource
  end
  
  def edit
    self.resource = find_resource
    render "_form"
  end
  
  def update
    find_resource.update_attributes(params[self.resource_name.to_sym])
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
    find_resource.destroy
    redirect_to collection_url
  end

end
