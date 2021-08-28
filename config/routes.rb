Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  # Genera las rutas
  resources :employees, except: [:show]
  resources :records
  resources :profiles, only: [:show, :edit, :update]

  get '/searchEmpleado', to: 'search#list'
  post '/searchEmpleado', to: 'search#list'

  get '/searchInCalendar', to: 'search#calendar'
  post '/searchInCalendar', to: 'search#calendar'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
