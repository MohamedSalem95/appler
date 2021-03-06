class AppointmentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:already_in]
    before_action :authenticate_user!

    def show
        @appointment = Appointment.find(params[:id])
        render json: @appointment
    end

    # for sec
    def index
        authorize :appointment, :index?
        @appointments = Appointment.for_today
    end

    def today_approve
        @appointments = Appointment.today_approve
        render json: @appointments
    end

    # for manager
    def manager
        authorize :appointment, :manager?
        @appointments = Appointment.for_today
    end

    def appointment
        authorize :appointment, :appointment?
        @appointments = current_user.appointments.latest
        @today = current_user.appointments.for_today
    end

    def new
        authorize :appointment, :new?
        @from_list = [['داخل الاداره', 1], ['خارج الاداره', 2]]
        @appointment = Appointment.new
    end

    def create
        authorize :appointment, :create?
        @from_list = [['داخل الاداره', 1], ['خارج الاداره', 2]]
        @appointment = Appointment.new(appointment_params)
        @appointment.name = current_user.name
        @appointment.user = current_user
        if @appointment.save
            flash[:success] = 'تم انشاء المعاد بنجاح  🥳 '
            redirect_to root_path
        else
            render :new
        end
    end

    def delay
        authorize :appointment, :delay?
        @appointment = Appointment.find(params[:id])
    end

    def add_note
        authorize :appointment, :add_note?
        @appointment = Appointment.find(params[:id])
    end

    def add_note_save
        authorize :appointment, :add_note_save?
        @appointment = Appointment.find(params[:id])
        if @appointment.update(notes_params)
            flash[:success] = 'تم اضافه الملحوظه بنجاح.'
            render :add_note
        else
            render :add_note
        end
    end

    def delay_save
        authorize :appointment, :delay_save?
        @appointment = Appointment.find(params[:id])
        @appointment.status = 3
        if @appointment.update(appointment_delay_params)
            flash[:success] = 'تم تاجيل الميعاد بنجاح'
            redirect_to appointments_path
        else
            render :delay
        end
    end

    def already_in
        @appointment = Appointment.find(params[:id])
        @appointment.update_attribute(:status, 5)
        render json: { success: true }
    end


    private
    def appointment_params
        params.require(:appointment).permit(:from, :department, :app_date, :app_time, :file, :description)
    end

    def appointment_delay_params
        params.require(:appointment).permit(:delay_date, :app_time)
    end

    def update_status_params
        params.require(:appointment).permit(:status)
    end

    def notes_params
        params.require(:appointment).permit(:notes)
    end
end
