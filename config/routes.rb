Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'welcome#index'

  match '/:trap_id',            to: 'requests#create', via: :all
  get '/:trap_id/requests',     to: 'requests#index', as: 'requests'
  get '/:trap_id/requests/:id', to: 'requests#show',  as: 'request'

  get '/:trap_id/stream', to: 'requests_stream#event'
end
