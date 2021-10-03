# Preview all emails at http://localhost:3000/rails/mailers/appointment_mailer
class AppointmentMailerPreview < ActionMailer::Preview
    def send_mail
        @data = {subject: 'test mail', contact: 'mo@gmail.com', message: 'my message'}
        AppointmentMailer.with(@data).send_mail
    end
end
