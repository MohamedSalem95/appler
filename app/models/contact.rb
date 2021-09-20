class Contact < ApplicationRecord

    scope :latest, -> { order(created_at: :desc) }

    validates_presence_of :name, message: 'من فضلك ادخل الاسم'
    validates_presence_of :email, message: 'من فضلك ادخل الايميل'
    validates :email, format: { with: Devise.email_regexp, message: 'من فضلك ادخل ايميل صالح' }

end
