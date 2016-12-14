class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, required: false
  belongs_to :group, required: false

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
