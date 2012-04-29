class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :assignments
  has_many :roles, :through => :assignments
  
  has_many :pictures
  has_many :galleries 
  
  after_create :add_standard_role
  
  
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  
protected
  def add_standard_role
    standard_role = Role.find_by_name( ROLE_NAME[:standard] )
    if not self.has_role?(:standard)
      self.roles << standard_role
      self.save 
    end
  end
  
  
end
