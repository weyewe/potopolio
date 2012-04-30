class GalleriesController < ApplicationController
  
  def new
    @new_gallery = Gallery.new 
    setup_select_gallery
    add_breadcrumb "Create Gallery", "new_gallery_url"
  end
  
  def create
    @new_gallery = Gallery.new( params[:gallery])
    
    if @new_gallery.save 
      redirect_to add_pics_to_gallery_url(@new_gallery)
    else
      
      add_breadcrumb "Create Gallery", "new_gallery_url"
    end
  end
  
  
  def select_gallery_to_be_edited
    setup_select_gallery
  end
  
  def select_gallery_to_upload_more_pics
    setup_select_gallery
  end
  
  protected
  def setup_select_gallery
    @galleries = Gallery.all
  end
end
