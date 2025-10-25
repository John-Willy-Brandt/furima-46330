Rails.application.routes.draw do
   get 'items/index'
  root 'items#index'   # This makes it the homepage
end
