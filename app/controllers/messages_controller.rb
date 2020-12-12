class MessagesController < ApplicationController
  skip_forgery_protection only: %i(create)
  before_action :set_channel, only: %i[create]

  def create
    message = @channel.messages.new(message_params)
    message.user = current_user
    if message.save
      render json: { errors: [] }, status: :created
    else
      render json: { errors: channel.errors.full_messages }, status: :ok
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def message_params
    params.require(:channel).permit(:content)
  end
end