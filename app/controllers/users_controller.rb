class UsersController < ApplicationController

  def index
    @users = User.where.not(id: Participation.where(channel_id: params[:channel_id]).select(:user_id)).order(:id)
    @users = @users.ransack(name_cont: params[:name]).result if params[:name].present?
    render json: @users
  end
end