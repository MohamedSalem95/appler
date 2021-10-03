class AppointmentMailer < ApplicationMailer

    def send_mail
        @subject = params[:subject]
        @message = params[:message]
        @to = params[:contact]
        mail(to: @to, subject: @subject)
    end

end
