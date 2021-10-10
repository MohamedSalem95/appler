class ContactsController < ApplicationController

    before_action :authenticate_user!

    def index
        authorize :contact, :index?
        @contacts = Contact.latest
    end

    def new
        authorize :contact, :new?
        @contact = Contact.new
    end

    def create
        authorize :contact, :create?
        @contact = Contact.new(contact_params)
        if @contact.save
            flash[:success] = 'تم انشاء جهة الاتصال بنجاح.'
            redirect_to contacts_path
        else
            render :new
        end
    end

    def mail
        authorize :contact, :mail?
        @contacts = Contact.all.map { |contact| [contact.name, contact.email] }
    end

    def mail_send
        authorize :contact, :send_mail?
        AppointmentMailer.with(mail_params).send_mail.deliver_later
        flash[:success] = 'تم ارسال الايميل بنجاح.'
        redirect_to contacts_path
    end
    
    private
    def contact_params
        params.require(:contact).permit(:name, :email)
    end

    def mail_params
        params.require(:mail).permit(:contact, :subject, :message)
    end

end
