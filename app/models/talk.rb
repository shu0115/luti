class Talk < ActiveRecord::Base
  attr_accessible :name, :user_id
  
  has_many :pages, dependent: :delete_all
end
