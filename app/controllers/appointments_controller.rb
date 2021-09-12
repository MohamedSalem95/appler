class AppointmentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:already_in]

    def show
        @appointment = Appointment.find(params[:id])
        render json: @appointment
    end

    # for sec
    def index
        @appointments = Appointment.for_today
    end

    def today_approve
        @appointments = Appointment.today_approve
        render json: @appointments
    end

    # for manager
    def manager
        @appointments = Appointment.for_today
    end

    def new
        @from_list = [['داخل الاداره', 1], ['خارج الاداره', 2]]
        @appointment = Appointment.new
    end

    def create
        @from_list = [['داخل الاداره', 1], ['خارج الاداره', 2]]
        @appointment = Appointment.new(appointment_params)
        if @appointment.save
            flash[:success] = 'تم انشاء المعاد بنجاح  🥳 '
            redirect_to appointments_path
        else
            render :new
        end
    end

    def delay
        @appointment = Appointment.find(params[:id])
    end

    def delay_save
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
        params.require(:appointment).permit(:name, :from, :department, :app_date, :app_time, :description)
    end

    def appointment_delay_params
        params.require(:appointment).permit(:delay_date, :app_time)
    end

    def update_status_params
        params.require(:appointment).permit(:status)
    end

end
