class ApplicationController < ActionController::Base
  include Transloadit::Rails::ParamsDecoder
  protect_from_forgery
  before_filter :authenticate_user!

  layout :layout_by_resource

  def only_role(role_symbol)
    if not current_user.has_role?(role_symbol)
      redirect_to root_url 
    end
  end

  def layout_by_resource
    
    puts "We are here!!! \n"*10
    puts "#{params}"
    if ( devise_controller? && resource_name == :user && action_name == 'new' ) or
        (params[:controller]  == "home" && params[:action] == "new_user_sign_up")
      "devise"
    elsif params[:controller] == "home" && params[:action] == "welcome"
      "welcome"
    else
      "application"
    end
    
    
  end
  
  
  def after_sign_in_path_for(resource)
    if current_user.has_role?( :standard)
      return new_picture_url
    end
    if current_user.has_role?( :premium)
      return "http://facebook.com"
    end
    
   
  end



  def ensure_has_school_admin_role
    if not current_user.has_role?(:school_admin)
      redirect_to root_url 
    end
  end
  
  def set_breadcrumb_for object, destination_path, opening_words
    # puts "THIS IS WILLLLLY\n"*10
    # puts destination_path
    add_breadcrumb "#{opening_words}", destination_path
  end
  
  
  def has_membership?(  membership_class, membership_provider_id , membership_consumer_id )
    # check the role why do we need to check the role? just check the membership .clear cut. 
    # has the membership? ok, you can see. no membership? you can see the root_url
      # check the ownership 
    membership_class_sym = membership_class.to_s.underscore.to_sym
    provider_property = MEMBERSHIP_DATA[membership_class_sym][:provider_property] 
    consumer_property = MEMBERSHIP_DATA[membership_class_sym][:consumer_property] 
    
    membership = membership_class.send(:find, :first, :conditions => {
      provider_property.to_sym => membership_provider_id , 
      consumer_property.to_sym => membership_consumer_id
    } )
    
    not membership.nil?
  end
  
  def ensure_role(role_sym)
    if not current_user.has_role?(role_sym)
      redirect_to root_url 
      return 
    end
  end
  
  
=begin
  Cleaning out those caching
=end

  def expire_grading_gallery_list_cache( project ) 
    expire_fragment( "gallery_grading_list_#{project.id}"  )
  end
  
  protected
  def add_breadcrumb name, url = ''
    @breadcrumbs ||= []
    url = eval(url) if url =~ /_path|_url|@/
    @breadcrumbs << [name, url]
  end

  def self.add_breadcrumb name, url, options = {}
    before_filter options do |controller|
      controller.send(:add_breadcrumb, name, url)
    end
  end
  
end
