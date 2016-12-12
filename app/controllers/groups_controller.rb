# class GroupsController < ApplicationController

#   def close
#     @group = Group.find(params[:id])

#     session[:groups].delete(@group.id)

#     respond_to do |format|
#       format.js
#     end
#   end

#   private

#   def add_to_groups
#     session[:groups] ||= []
#     session[:groups] << @group.id
#   end

#   def conversated?
#     session[:groups].include?(@group.id)
#   end
# end
