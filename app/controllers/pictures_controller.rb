class PicturesController < ApplicationController
  def new
    # put pagination, for every 50 .hahaha 
    @new_picture = Picture.new
    @pictures = current_user.pictures.limit(50).order("created_at DESC")
    
    add_breadcrumb "Add Pictures", "new_picture_url"
  end
  
  
  
  def create
    
    new_picture = ""
    if not params[:transloadit].nil? and not params[:picture_filetype].nil?
      if params[:picture_filetype].to_i ==  PICTURE_FILETYPE[:image]  
        puts "Strangely, we are inside the image\n"*10
        new_picture = Picture.extract_uploads( 
          params[:transloadit][:results][":original".to_sym],
          params[:transloadit][:results][:resize_index], 
          params[:transloadit][:results][:resize_show], 
          params[:transloadit][:results][:resize_revision], 
          params, params[:transloadit][:uploads], PIC_UPLOAD_TYPE[:basic], current_user, nil )
          
      elsif params[:picture_filetype].to_i !=  PICTURE_FILETYPE[:image]  
        puts "Yeah baby, we are inside the scribd\n"*10
        new_picture = Picture.extract_scribd_upload( 
          params[:transloadit][:results][":original".to_sym],
          params, params[:transloadit][:uploads] )
      end
      
    end 
      
      # expiring the fragment used in gallery_mode_grading
    # if not new_picture.nil?  
    #      expire_fragment( "gallery_grading_list_project_submission_#{@project_submission.id}" )
    #    end
      
    # if params[:original_picture_id].nil?
    #       # it is from new picture page
    #       redirect_to new_project_submission_picture_path(@project_submission)
    #     else 
    #       # it is to create revision
    #       redirect_to project_submission_picture_path(@project_submission,new_picture)
    #     end
    
    redirect_to new_picture_url 
  end
  
  
  def add_pics_to_gallery
    @gallery = Gallery.find_by_id params[:gallery_id]
    @pictures = @gallery.pictures.order("created_at DESC")
    @new_picture = Picture.new 
  end
  
  
end
