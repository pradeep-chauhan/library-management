Rails.application.routes.draw do
  devise_for :users,
  path: '',
  path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
  },
  controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
  }
  resources :users, only: %i[index show]
  resources :libraries, only: [:show] do
    resources :books, only: [:index]
  end
end