Nifmon::Application.routes.draw do
  resources :polls, :services
  resource :dashboard
end
