Rails.application.routes.draw do
  get '/:post_slug/', to: 'posts#show', as: :parent_post
  get '/:post_slug/:subpost_slug', to: 'posts#show', as: :child_post
end
