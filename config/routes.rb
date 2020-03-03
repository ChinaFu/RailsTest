Rails.application.routes.draw do
  root 'net_packets#index'
  post '/net_packets/search',to: 'net_packets#search'
  post '/net_packets/refresh',to: 'net_packets#refresh'
  post '/net_packets/mydebug',to: 'net_packets#mydebug'
  resources :net_packets
end