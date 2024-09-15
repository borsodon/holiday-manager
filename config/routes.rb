# frozen_string_literal: true

Rails.application.routes.draw do
  resources :employees do
    resources :vacation_requests, only: %i[new create index] do
      member do
        patch :accept
        patch :decline
      end
    end
  end

  resources :vacation_requests, only: [:index]

  root 'employees#index'
end
