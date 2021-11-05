Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'user#index'
  patch "/user/remove", to: "user#remove"
  post "/user/validate", to: "user#validate"
  post "/user/change_password" , to: "user#changePassword"
  post "/auth/login" , to: "user#login"
  post "/user/validate-edit", to: "user#validateEdit"

  post "/user/resetPasswordData", to:"user#resetPasswordData"
  post "/user/resetPassword", to:"user#resetPassword"
  get "/user/email", to:"user#email"
  post "/user/updatePassword", to:"user#updatePassword"

  resources :user 

  post "/post/validate", to: "post#validate"
  patch "/post/remove", to: "post#remove"
  post "/post/validate-edit", to: "post#validateEdit"
  get "/post/download", to: "post#download"
  post "/post/upload", to: "post#upload"
  resources :post
end
