class Appointment < ApplicationRecord

    # scopes
    scope :for_today, -> { where(app_date: Date.today).or(where(delay_date: Date.today)).order(app_time: :asc) }
    scope :today_approve, -> { where(app_date: Date.today).or(where(delay_date: Date.today)).order(approval_time: :desc) }

    #validations
    validates_presence_of :name, message: 'من فضلك ادخل الاسم  🙂 '
    validates_presence_of :from, message: 'من فضلك ادخل الجهه  🤓 '
    validates_presence_of :app_date, message: ' من فضلك ادخل التاريخ  😤 '
    # validates_presence_of :delay_date, message: ' من فضلك ادخل التاريخ  😤 ', unless: -> { self.new_record? }
    validates_presence_of :app_time, message: ' من فضلك ادخل الوقت  😡  '

    # callbacks
    after_update_commit { AppointmentUpdateJob.perform_now self }
    after_create_commit { AppointmentCreateJob.perform_now self }

end
