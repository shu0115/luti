class Talk < ActiveRecord::Base
  
  attr_accessible :name, :user_id
  
  has_many :pages, dependent: :delete_all
  
  #-----------#
  # own_user? #
  #-----------#
  def own_user?( user_id )
    return true if self.user_id == user_id
    return false
  end
  
end
