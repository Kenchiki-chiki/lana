class ParticipationsController < ApplicationController
  skip_forgery_protection only: %i(create)
  before_action :set_channel, only: %i[create]

  def create
    participation = @channel.participations.new(participation_params)
    if participation.save
      render json: { errors: [] }, status: :created
    else
      render json: { errors: participation.errors.full_messages }, status: :ok
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def participation_params
    params.require(:participation).permit(:user_id)
  end
end