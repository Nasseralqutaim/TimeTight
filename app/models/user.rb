class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :initiated_call_sessions, class_name: 'CallSession', foreign_key: 'initiator_id'
  has_many :received_call_sessions, class_name: 'CallSession', foreign_key: 'recipient_id'
end
