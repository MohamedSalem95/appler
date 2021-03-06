class AppointmentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appointment_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def approve(data)
    @appointment = Appointment.find(data['id'])
    @appointment.update!(status: 2, approval_time: Time.now)
  end

  def cancel(data)
    @appointment = Appointment.find(data['id'])
    @appointment.update!(status: 4)
  end

  def ready(data)
    @appointment = Appointment.find(data['id'])
    @appointment.update!(status: 6)
  end
end
