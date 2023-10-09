class CallSession < ApplicationRecord
  
  belongs_to :initiator, class_name: "User"
  belongs_to :recipient, class_name: "User"
  has_many :agenda_items
  has_many :feedbacks

end
