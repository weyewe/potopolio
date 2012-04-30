# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Potopolio::Application.initialize!



TRUE_CHECK = 1
FALSE_CHECK = 0


ORIGINAL_PICTURE   = 1
REVISION_PICTURE   = 0

ACCEPT_SUBMISSION = 1
REJECT_SUBMISSION = 0

ROLE_NAME = {
  :standard => "Standard",
  :premium => "Premium"
}


PICTURE_FILETYPE = {
  :image => 1,
  :doc => 2,
  :ppt => 3,
  :xls => 4,
  :pdf => 5,
  :open_document => 6,
  :open_office_xml => 7,
  :plain_text => 8,
  :postscript => 9,
  :rtf => 10,
  :tif => 11, 
  :others => 999
}

FILETYPE_REGEX = {
  :doc => /(\.(doc|docx))$/,
  :ppt => /(\.(ppt|pps|pptx|ppsx))$/,
  :xls => /(\.(xls|xlsx))$/,
  :pdf => /(\.(pdf))$/,
  :open_document => /(\.(odt|odp|ods|odf|odg))$/,
  :open_office_xml => /(\.(sxw|sxi|sxc|sxd))$/,
  :plain_text => /(\.(txt))$/,
  :postscript => /(\.(ps))$/,
  :rtf => /(\.(rtf))$/,
  :tif => /(\.(tif|tiff))$/
}

FILEICON_URL= {
  :doc => 'https://s3.amazonaws.com/potoschool_icon/doc_file_icon1.png',
  :ppt => 'https://s3.amazonaws.com/potoschool_icon/recover-powerpoint-presentations.png',
  :xls => 'https://s3.amazonaws.com/potoschool_icon/Excel-icon.png',
  :pdf => 'https://s3.amazonaws.com/potoschool_icon/pdf_icon-300x300.png',
  :open_document => 'https://s3.amazonaws.com/potoschool_icon/odt.png',
  :open_office_xml => 'https://s3.amazonaws.com/potoschool_icon/open_office.png',
  :plain_text => 'https://s3.amazonaws.com/potoschool_icon/txt.png',
  :postscript => 'https://s3.amazonaws.com/potoschool_icon/post_script.png',
  :rtf => 'https://s3.amazonaws.com/potoschool_icon/rtf_icon.png',
  :tif => 'https://s3.amazonaws.com/potoschool_icon/tif_icon.png', 
  :others => 'https://s3.amazonaws.com/potoschool_icon/other_file_type.png'
}



PIC_UPLOAD_TYPE = {
  :basic => 1 , 
  :gallery => 2 , 
  :forum_post => 3 
}
