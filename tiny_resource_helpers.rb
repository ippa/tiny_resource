module TinyResourceHelpers
  
  #
  # View helpers, names taken from Jose Valims inherited_resources
  #

  # => /projects
  def collection_url
    url_for(:controller => collection_name, :only_path => true)
  end

  # => /projects/5
  def resource_url(resource)
    url_for(:controller => collection_name, :id => (resource || self.resource.id), :only_path => true)
  end

  # => /projects/5/edit
  def edit_resource_url(resource)
    url_for(:controller => collection_name, :action => "edit", :id => (resource || self.resource.id), :only_path => true)
  end

  # => /projects/new
  def new_resource_url
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
    self.class.to_s.gsub("Controller","").singularize.constantize
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
    instance_variable_get("@#{resource_name}")
  end

  # If called from ProjectsController: set instance variable @project
  def resource=(data)
    instance_variable_set("@#{resource_name}", data)
    @resource = data
  end

  # If called from ProjectsController: return @projects
  def collection
    instance_variable_get(collection_name)
  end
  
  # If called from ProjectsController: set instance variable @projects
  def collection=(data)
    instance_variable_set("@#{collection_name}", data)
    @collection = data
  end
end
