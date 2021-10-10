class ContactPolicy < ApplicationPolicy

    def index?
        is_manager?
    end

    def new?
        is_manager?
    end

    def create?
        is_manager?
    end

    def mail?
        is_manager?
    end

    def send_mail?
        is_manager?
    end

    private
    def is_manager?
        user.has_role? 2
    end

end