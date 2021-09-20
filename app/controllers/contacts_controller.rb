class ContactsController < ApplicationController

    def index
        @contacts = Contact.latest
    end

    def new
        @contact = Contact.new
    end

    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            flash[:success] = 'تم انشاء جهع الاتصال بنجاح.'
            redirect_to contacts_path
        else
            render :new
        end
    end


    private
    def contact_params
        params.require(:contact).permit(:name, :email)
    end

end
