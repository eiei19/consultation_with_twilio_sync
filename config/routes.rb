Rails.application.routes.draw do
  root 'index#index'
  get 'sync_token', to: "tokens#sync"
  get 'phone_token', to: "tokens#phone"
  post 'voice', to: "index#voice"
end
