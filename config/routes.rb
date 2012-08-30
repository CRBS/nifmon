Nifmon::Application.routes.draw do
  resources :polls, :services

  match 'dashboard' => 'dashboard#show', :as => :dashboard, :via => :get
  match 'dashboard' => 'dashboard#update', :via => :put
  match 'dashboard/edit' => 'dashboard#edit', :as => :edit_dashboard, :via => :get

end
