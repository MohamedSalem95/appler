class UserPolicy < ApplicationPolicy

    def dashboard?
        is_admin?
    end

    def managers?
        is_admin?
    end

    def sec?
        is_admin?
    end

    def admin?
        is_admin?
    end

    def normal?
        is_admin?
    end


    private
    def is_admin?
        user.has_role? 0
    end

end