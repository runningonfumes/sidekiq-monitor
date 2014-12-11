require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 2, :host => 'redis' }
end

require 'sidekiq/web'
run Sidekiq::Web
