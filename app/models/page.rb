class Page < ActiveRecord::Base
  attr_accessible :contents, :number, :talk_id, :user_id, :note, :title
  
  belongs_to :talk
end
