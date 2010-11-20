#
# A base for "admin-on-the-homepage" popup editing
# Does Rails3 style rendering of "_form" on new/edit
#
class TinyPopupResourceController < TinyResourceController
  
  def new
    super
    render "_form"
  end
  
  def edit
    super
    render "_form"
  end

  def update
    super
    redirect_to :back
  end

  def create
    super
    redirect_to resource_path
  end

  def destroy
    super
    redirect_to collection_path
  end

end
