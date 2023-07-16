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
  resources :libraries, only: %i[index show] do
    resources :books, only: %i[index show]
  end
end