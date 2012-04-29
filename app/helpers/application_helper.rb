module ApplicationHelper
  
  ACTIVE = 'active'
  REVISION_SELECTED = "selected"
  NEXT_BUTTON_TEXT = "Next &rarr;"
  PREV_BUTTON_TEXT = " &larr; Prev "
=begin
  Our version of transloadit 
=end

  def transloadit_with_max_size( template , size_mb )

    if Rails.env.production?
      transloadit_read = YAML::load( File.open( Rails.root.to_s + "/config/transloadit.yml") )
    elsif Rails.env.development?
      transloadit_read = YAML::load( File.open( Rails.root.to_s + "/config/transloadit_dev.yml") )
    end




    auth_key = transloadit_read['auth']['key']
    auth_secret = transloadit_read['auth']['secret']
    duration = transloadit_read['auth']['duration']
    template = transloadit_read['templates'][template]

    params = JSON.generate({
      :auth => {
        :expires => (Time.now + duration).utc.strftime('%Y/%m/%d %H:%M:%S+00:00') ,
      # Time.now.utc.strftime('%Y/%m/%d %H:%M:%S+00:00'),
        :key => auth_key,
        :max_size => size_mb*1024*1024
      },
      :template_id => template 
    })


    digest = OpenSSL::Digest::Digest.new('sha1')
    signature = OpenSSL::HMAC.hexdigest(digest, auth_secret, params)
    [params, signature]
  end

  
  
=begin
  General command to create Guide in all pages
=end 
  def create_guide(title, description)
    result = ""
    result << "<div class='explanation-unit'>"
    result << "<h1>#{title}</h1>"
    result << "<p>#{description}</p>"
    result << "</div>"
  end
  
  
  
  def create_breadcrumb(breadcrumbs)
    
    if (  breadcrumbs.nil? ) || ( breadcrumbs.length ==  0) 
      # no breadcrumb. don't create 
    else
      breadcrumbs_result = ""
      breadcrumbs_result << "<ul class='breadcrumb'>"
      
      puts "After the first"
      
      
      breadcrumbs[0..-2].each do |txt, path|
        breadcrumbs_result  << create_breadcrumb_element(    link_to( txt, path ) ) 
      end 
      
      puts "After the loop"
      
      last_text = breadcrumbs.last.first
      last_path = breadcrumbs.last.last
      breadcrumbs_result << create_final_breadcrumb_element( link_to( last_text, last_path)  )
      breadcrumbs_result << "</ul>"
      return breadcrumbs_result
    end
    
    
  end
  
  def create_breadcrumb_element( link ) 
    element = ""
    element << "<li>"
    element << link
    element << "<span class='divider'>/</span>"
    element << "</li>"
    
    return element 
  end
  
  def create_final_breadcrumb_element( link )
    element = ""
    element << "<li class='active'>"
    element << link 
    element << "</li>"
    
    return element
  end
  
  
  
  
=begin
  Process Navigation related activity
=end  

  
  def get_process_nav( symbol, params)
    
    if symbol == :basic_upload
      return create_process_nav(BASIC_UPLOAD_PROCESS_LIST, params )
    end
    
    if symbol == :gallery_upload 
      return create_process_nav(GALLERY_UPLOAD_PROCESS_LIST, params )
    end
    
    if symbol == :teacher
      return create_process_nav(TEACHER_PROCESS_LIST, params )
    end
    
    if symbol == :submission_grading 
      return create_process_nav(SUBMISSION_GRADING_PROCESS_LIST, params )
    end
    
    if symbol == :student 
      return create_process_nav(STUDENT_PROCESS_LIST, params )
    end
    
    if symbol == :settings
      return create_process_nav(SETTINGS_PROCESS_LIST, params )
    end
  end
  
  
  
  
  protected 
  
  #######################################################
  #####
  #####     Start of the process navigation code 
  #####
  #######################################################
   
  def create_process_nav( process_list, params )
     result = ""
     result << "<ul class='nav nav-list'>"
     result << "<li class='nav-header'>  "  + 
                 process_list[:header_title] + 
                 "</li>"         

     process_list[:processes].each do |process|
       result << create_process_entry( process, params )
     end

     result << "</ul>"

     return result
   end
   
   
  
  
  
  def create_process_entry( process, params )
    is_active = is_process_active?( process[:conditions], params)
    
    process_entry = ""
    process_entry << "<li class='#{is_active}'>" + 
                      link_to( process[:title] , extract_url( process[:destination_link] )    )
    
    return process_entry
  end
  
  def is_process_active?( active_conditions, params  )
    active_conditions.each do |condition|
      if condition[:controller] == params[:controller] &&
        condition[:action] == params[:action]
        return ACTIVE
      end

    end

    return ""
  end
  
  def extract_url( some_url )
    if some_url == '#'
      return '#'
    end
    
    eval( some_url ) 
  end
  
  
  #######################################################
  #####
  #####     Start of the process navigation KONSTANT
  #####
  #######################################################
  
  
  
  BASIC_UPLOAD_PROCESS_LIST = {
    :header_title => "Basic Upload",
    :processes => [
      {
        :title => "Upload + Latest",
        :destination_link => 'new_picture_url',
        :conditions => [
          {
            :controller => "pictures",
            :action => "new"
          },
          {
            :controller =>"pictures",
            :action => "show"
          }
        ]
      }
    ]
  }
  
  
  
  GALLERY_UPLOAD_PROCESS_LIST = {
    :header_title => "Gallery Upload",
    :processes => [
      {
        :title => "Create Gallery + Upload Pics",
        :destination_link => 'new_gallery_url',
        :conditions => [
          {
            :controller => "galleries",
            :action => "new"
          },
          {
            :controller =>"pictures",
            :action => "xx"
          },
          {
            :controller => "pictures",
            :action => "xx"
          }
        ]
      },
      {
        :title =>"Edit Gallery",
        :destination_link => "root_url",
        :conditions => [
          {
            :controller => "pictures",
            :action => 'xx'
          }
        ]
      },
      {
        :title =>"Upload More Pics to Gallery",
        :destination_link => "root_url",
        :conditions => [
          {
            :controller => "pictures",
            :action => 'xx'
          }
        ]
      }
    ]
  }
  
  
  
end
