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
end
