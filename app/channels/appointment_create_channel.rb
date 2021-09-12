class AppointmentCreateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appointment_create_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
