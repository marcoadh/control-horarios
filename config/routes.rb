Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  # Genera las rutas
  resources :employees, except: [:show]
  resources :records
  resources :search
  resources :profiles, only: [:show, :edit, :update]
  resources :documents

  get 'report', to: 'reports#report'
  post 'report', to: 'reports#report'

  get 'export', to: 'reports#export'
  post 'export', to: 'reports#export'

  get 'searchInCalendar', to: 'search#calendar'
  post 'searchInCalendar', to: 'search#calendar'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
