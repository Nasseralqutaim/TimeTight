class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  def call_sessions
    initiated_call_sessions.or(received_call_sessions)
  end

  has_many :initiated_call_sessions, class_name: 'CallSession', foreign_key: 'initiator_id'
  has_many :received_call_sessions, class_name: 'CallSession', foreign_key: 'recipient_id'
end

