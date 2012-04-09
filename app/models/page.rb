class Page < ActiveRecord::Base
  attr_accessible :contents, :number, :talk_id, :user_id
end
