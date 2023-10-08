class CallSession < ApplicationRecord
  belongs_to :initiator
  belongs_to :recipient
end
