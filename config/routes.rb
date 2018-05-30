Rails.application.routes.draw do
  resource :links, only: %i[show create]

  get '/:token', to: 'clicks#index', as: 'click'

  root to: 'links#show'
end
