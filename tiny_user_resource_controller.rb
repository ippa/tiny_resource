class TinyUserResourceController < ApplicationController
  require File.join(File.dirname(__FILE__), 'tiny_resource_helpers.rb')
  include TinyResourceHelpers
  helper_method :collection_url, :resource_url, :edit_resource_url, :new_resource_url
  helper_method :resource, :collection, :model

  #
  # This is simular to TinyResourceController but it goes through current_user when doing model-work. 
  # This ensures that only resource that current_user owns can be modified by the current current_user :)
  #

  def index
    self.collection = current_user.send(collection_name).all
  end
  
  def show
    self.resource = current_user.send(collection_name).find(params[:id])
  end
  
  def edit
    self.resource = current_user.send(collection_name).find(params[:id])
    render "_form"
  end

  def update
    current_user.send(collection_name).find_by_id(params[:id]).update_attributes(params[self.resource_name.to_sym])
    redirect_to :back
  end

  def new
    self.resource = current_user.send(collection_name).new
    render "_form"
  end

  def create
    self.resource = current_user.send(collection_name).new(params[self.resource_name.to_sym]).save
    redirect_to :back
  end

  def destroy
    current_user.send(collection_name).find(params[:id]).destroy
    redirect_to collection_url
  end

end
