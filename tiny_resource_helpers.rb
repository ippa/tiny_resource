module TinyResourceHelpers
  
  #
  # View helpers, names taken from Jose Valims inherited_resources
  #

  # => /projects
  def collection_url
    url_for(:controller => collection_name)
  end
  def collection_path
    url_for(:controller => collection_name, :only_path => true)
  end

  # => /projects/5
  def resource_url(resource = nil)
    url_for(resource || self.resource)
  end
  def resource_path(resource = nil)
    url_for(resource || self.resource)
  end

  # => /projects/5/edit
  def edit_resource_url(resource = nil)
    # [:edit, resource] ?!? se http://www.railsdispatch.com/
    url_for(:controller => collection_name, :action => "edit", :id => (resource || self.resource.id))
  end
  def edit_resource_path(resource = nil)
    url_for(:controller => collection_name, :action => "edit", :id => (resource || self.resource.id), :only_path => true)
  end

  # => /projects/new
  def new_resource_url
    url_for(:controller => collection_name, :action => "new")
  end
  def new_resource_path
    url_for(:controller => collection_name, :action => "new", :only_path => true)
  end

  #
  # Controller helpers
  #

  #
  # Return the ActiveRecord::Base model associated with the controller
  # i.e. Controller ProjectController returns model Project
  #
  def model
    model_name = self.class.to_s.gsub("Controller","").singularize

    # For example, if Admin::Product fails it tries just Product
    model_name.constantize  rescue  model_name.demodulize.constantize
  end

  # ProjectsController will return "project"
  def resource_name
    self.model.to_s.underscore
  end

  # ProjectsController will return "projects"
  def collection_name
    self.model.to_s.tableize
  end

  # If called from ProjectsController: return @project
  def resource
    @resource ||= model.find(params[:id])
  end

  def find_resource
    resource
  end

  # If called from ProjectsController: set instance variable @project
  def resource=(data)
    instance_variable_set("@#{resource_name}", data)
    @resource = data
  end

  # If called from ProjectsController: return @projects
  def collection
    @collection ||= model.all
  end
  
  # If called from ProjectsController: set instance variable @projects
  def collection=(data)
    instance_variable_set("@#{collection_name}", data)
    @collection = data
  end
end
