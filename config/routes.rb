Actly::Application.routes.draw do
  get "password_resets/new"

  resources :events
  resources :blocks
  resources :invitations
  resources :contacts
  resources :rsvps
  resources :followings
  resources :suggestions
  resources :actions
  resources :users
  resources :sessions
  resources :password_resets

  resources :invitations do
    member do
      post 'add_invitees'
      post 'invite_contacts'
      post 'unfollow'
      post 'follow'
    end
  end

  resources :suggestions do
    member do
      post 'new'
    end
  end

  match 'auth/:inv', to: 'sessions#create_from_email'

  resources :rsvps do
    member do
      post 'favor'
      post 'confirm'
      post 'decline'
      post 'maybe'
    end
  end

  resources :events do
    member do
      get 'step2'
      get 'step3'
      post 'add_invitees'
      post 'add_comment'
    end
  end

  get "static_pages/home"

  get "sessions/new"

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'static_pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
