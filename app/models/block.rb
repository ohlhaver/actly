class Block < ActiveRecord::Base
  attr_accessible :blocked_id, :blocker_id
  belongs_to :blocker, class_name: "User"
  belongs_to :blocked, class_name: "User"
end
