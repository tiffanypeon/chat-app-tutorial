class HomeController < ApplicationController
  def index
    session[:conversations] ||= []
    session[:groups] ||= []

    @users = User.all.where.not(id: current_user)
    @active_groups, @inactive_groups = get_user_groups
    @conversations = Conversation.includes(:recipient, :messages)
      .find(session[:conversations])
  end

  def get_user_groups
    Group.all.partition { |group| group.users.where(id: current_user.id).present? }
  end
end
