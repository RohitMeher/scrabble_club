Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :members
  resources :matches

  get 'member/leader_board',      to: 'members#leader_board',   as: 'member_leader_board'

  root 'members#index'
end