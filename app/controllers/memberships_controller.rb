class MembershipsController < ApplicationController

  def create
    @membership = Membership.find_or_create_by!(user_id: current_user.id, group_id: params[:group_id])
    @group = @membership.group
    add_to_groups unless already_joined?

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    session[:groups].delete(@membership.group.id)
    @group_id = @membership.group.id
    @membership.destroy!

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_groups
    session[:groups] ||= []
    session[:groups] << @group.id
  end

  def already_joined?
    session[:groups].include?(@group.id)
  end
end
