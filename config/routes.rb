Rails.application.routes.draw do
  resources :appointments
  get 'welcome/index'

  get 'appointments/manager/dashboard', to: 'appointments#manager', as: 'appointment_manager'
  get 'appointments/:id/delay', to: 'appointments#delay', as: 'appointment_delay'
  put 'appointments/:id/delay', to: 'appointments#delay_save', as: 'appointment_delay_save'
  get 'appointments/today_approve/today', to: 'appointments#today_approve'

  patch 'appointments/:id/already_in', to: 'appointments#already_in'

  root to: 'welcome#index', as: 'root'
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
