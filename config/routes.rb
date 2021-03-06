Rails.application.routes.draw do
  get 'users/dashboard', as: 'dashboard'
  get 'users/managers', as: 'managers'
  get 'users/sec', as: 'sec'
  get 'users/admin', as: 'admin'
  get 'users/normal', as: 'normal'

  # change user role
  get 'users/:id/change_role', to: 'users#change_role', as: 'user_change_role'
  put 'users/:id/change_role', to: 'users#change_role_save', as: 'user_change_role_save'

  get 'contacts/send_mail', to: 'contacts#mail', as: 'mail'
  post 'contacts/send_mail', to: 'contacts#mail_send', as: 'mail_send'
  resources :contacts
  devise_for :users
  get 'appointments/my_appointments', to: 'appointments#appointment', as: 'my_appointments'
  resources :appointments
  get 'welcome/index'

  get 'appointments/manager/dashboard', to: 'appointments#manager', as: 'appointment_manager'
  
  get 'appointments/:id/delay', to: 'appointments#delay', as: 'appointment_delay'
  put 'appointments/:id/delay', to: 'appointments#delay_save', as: 'appointment_delay_save'

  get 'appointments/:id/add_note', to: 'appointments#add_note', as: 'appointment_add_note'
  put 'appointments/:id/add_note', to: 'appointments#add_note_save', as: 'appointment_add_note_save'
  
  get 'appointments/today_approve/today', to: 'appointments#today_approve'

  patch 'appointments/:id/already_in', to: 'appointments#already_in'

  root to: 'welcome#index', as: 'root'
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
