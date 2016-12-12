class HomeController < ApplicationController
  def index
    session[:conversations] ||= []
    session[:groups] ||= []

    @users = User.all.where.not(id: current_user)
    @groups = Group.all
    @active_groups = get_user_groups
    @conversations = Conversation.includes(:recipient, :messages)
      .find(session[:conversations])
  end

  def get_user_groups
    Membership.where(user_id: current_user.id).map { |m| m.group }
  end
end
