class Page < ActiveRecord::Base
  attr_accessible :contents, :number, :talk_id, :user_id, :note, :title, :template
  
  belongs_to :talk

  #-----------#
  # own_user? #
  #-----------#
  def own_user?( user_id )
    return true if self.user_id == user_id
    return false
  end

end
