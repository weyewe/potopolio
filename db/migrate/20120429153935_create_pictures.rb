class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      
      t.integer :user_id 
      t.integer :gallery_id 
      t.integer :forum_post_id
      
      t.integer :pic_upload_type, :default => PIC_UPLOAD_TYPE[:basic] 
      
      
      t.string   :name
      t.integer  :project_submission_id
      # for them to put in the shite 
      t.string   :original_image_url
      # for displaying the uploaded file
      t.string   :index_image_url
      t.string   :display_image_url
      t.string   :revision_image_url
      
      t.integer  :original_image_size
      t.integer  :index_image_size
      t.integer  :display_image_size
      t.string   :revision_image_size
      
      t.boolean  :is_deleted,            :default => false
      
      # just in case that we want to go for some cool things :)
      # document hosting
      t.string   :doc_id
      t.string   :doc_access_key
      t.integer  :picture_filetype,      :default => 1
      t.boolean  :conversion_status,     :default => false
      
      
      t.timestamps
    end
  end
end
