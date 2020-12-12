class ChannelsController < ApplicationController
  skip_forgery_protection only: %i(create)
  before_action :set_channel, only: %i[show]

  def create
    channel = Channel.new(channel_params)
    channel.participations.build(user: current_user)
    if channel.save
      render json: { errors: [] }, status: :created
    else
      render json: { errors: channel.errors.full_messages }, status: :ok
    end
  end

  def show
    @channels = current_user.channels
    @messages = @channel.messages.joins(:user).select('users.name as user_name, content, messages.id').order(created_at: :desc).limit(50).to_a.reverse
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:name)
  end
end