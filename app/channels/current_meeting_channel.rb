class CurrentMeetingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_meeting_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def current(data)
    ActionCable.server.broadcast 'current_meeting_channel', id: data['id']
  end
end
