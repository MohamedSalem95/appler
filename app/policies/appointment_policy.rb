class AppointmentPolicy < ApplicationPolicy

    def index?
        is_sec?
    end

    def manager?
        is_manager?
    end

    def appointment?
        is_normal? or is_admin?
    end

    # change later and add sec
    def new?
        is_normal? or is_admin?
    end

    # change later and add sec
    def create?
        is_normal? or is_admin?
    end

    def delay?
        is_manager? or is_sec?
    end

    def delay_save?
        is_manager? or is_sec?
    end

    def add_note?
        is_manager? or is_sec?
    end

    def add_note_save?
        is_manager? or is_sec?
    end

    private
    def is_manager?
        user.has_role? 2
    end

    def is_sec?
        user.has_role? 1
    end

    def is_normal?
        user.has_role? 3
    end

    def is_admin?
        user.has_role? 0
    end

end