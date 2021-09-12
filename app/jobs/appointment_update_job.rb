class AppointmentUpdateJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    if appointment.status != 5
      ActionCable.server.broadcast 'appointment_channel', id: appointment.id
    elsif appointment.status != 3
      ActionCable.server.broadcast 'appointment_channel', id: appointment.id
    end
    ActionCable.server.broadcast 'appointment_status_channel', id: appointment.id, status: appointment.status
  end
end

