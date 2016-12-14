class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    if message.conversation.present?
      sender = message.user
      recipients = message.conversation.opposed_user(sender)

      broadcast_to_sender(sender, message)
      broadcast_to_recipient(recipient, message)
    else
      sender = message.user
      recipients = message.group.users.where.not(id: sender.id)

      broadcast_to_group_sender(sender, message)
      broadcast_to_recipients(recipients, message)
    end
  end

  private

  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      message: render_message(message, user),
      conversation_id: message.conversation.id
    )
  end

  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      window: render_window(message.conversation, user),
      message: render_message(message, user),
      conversation_id: message.conversation.id
    )
  end

  def broadcast_to_group_sender(user, message)
    ActionCable.server.broadcast(
      "groups-#{user.id}",
      message: render_message(message, user),
      group_id: message.group.id
    )
  end

  def broadcast_to_recipients(users, message)
    users.each do |user|
      ActionCable.server.broadcast(
        "groups-#{user.id}",
        window: render_group_window(message.group, user),
        message: render_message(message, user),
        group_id: message.group.id
      )
    end
  end

  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end

  def render_window(conversation, user)
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
  end

  def render_group_window(group, user)
    ApplicationController.render(
      partial: 'groups/group',
      locals: { group: group, user: user }
    )
  end
end
