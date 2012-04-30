class Picture < ActiveRecord::Base
  
  belongs_to :user 
  belongs_to :gallery 
  
  
  def get_icon( display_section ) 
    if self.picture_filetype == PICTURE_FILETYPE[:image]
      message = display_section + "_image_url"
      return self.send( message )
    else
      return FILEICON_URL[ PICTURE_FILETYPE.invert[ self.picture_filetype ]  ]
    end
  end
  
  
  
  def self.extract_uploads(resize_original, resize_index , resize_show, 
                      resize_revision, params, uploads , pic_upload_type, user, wrapper)
    
    new_picture = ""
    counter = 0 
    
    # start looping all the transloadit data
    uploads.each do |upload|
      original_id = upload[:original_id]
      
      image_name = Picture.extract_filename(resize_original, original_id)
      
      original_data = Picture.extract_data( resize_original , original_id )
      index_data = Picture.extract_data( resize_index , original_id )
      show_data = Picture.extract_data( resize_show , original_id )
      revision_data = Picture.extract_data( resize_revision , original_id )
      
      new_picture = Picture.create(
           :original_image_url =>   original_data[:url]        ,
           :index_image_url    =>   index_data[:url]          ,
           :revision_image_url =>   revision_data[:url]        ,
           :display_image_url  =>   show_data[:url]           ,
           :original_image_size    => original_data[:size]    ,
           :index_image_size       => index_data[:size]       ,
           :revision_image_size    => revision_data[:size]    ,
           :display_image_size     => show_data[:size]        ,
           :name => image_name,
           :user_id => user.id ,
           :pic_upload_type => pic_upload_type 
      )
      
      counter =  counter + 1 
      
      
      new_picture.set_wrapper( wrapper )
      
      
    end
      
    return new_picture
  end
  
  def set_wrapper( wrapper ) 
    if self.pic_upload_type == PIC_UPLOAD_TYPE[:basic]
    elsif self.pic_upload_type == PIC_UPLOAD_TYPE[:gallery]
      self.gallery_id = wrapper.id 
    elsif self.pic_upload_type == PIC_UPLOAD_TYPE[:forum_post]
      self.forum_post_id = wrapper.id 
    end
    
    self.save 
  end
  
  
  def Picture.extract_data( upload_result , original_id )
      
    result = {}
    upload_result.each do |s_index|
      if s_index[:original_id] == original_id 
        result[:url]  =  s_index[:url]
        result[:size] = s_index[:size]
        break
      end
    end
    return result 
  end
  
  def Picture.extract_filename( upload_result, original_id)
    image_name = ""
    upload_result.each do |s_index|
      if s_index[:original_id] == original_id 
        image_name =  s_index[:name]
        break
      end
    end
    return image_name 
  end
  
end
