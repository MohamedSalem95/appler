class AppointmentCreateJob < ApplicationJob
  queue_as :default

  def perform(appointment)
    if appointment.app_date == Date.today
      ActionCable.server.broadcast 'appointment_create_channel', id: appointment.id
    end
  end
end
