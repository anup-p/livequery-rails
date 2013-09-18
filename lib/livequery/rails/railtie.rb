# Used to ensure that Rails 3.0.x, as well as Rails >= 3.1 with asset pipeline disabled
# get the minified version of the scripts included into the layout in production.
module Livequery
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do
        if config.action_view.javascript_expansions
          livequery_defaults = ::Rails.env.production? || ::Rails.env.test? ? %w(livequery.min) : %w(livequery)
        end
      end
    end
  end
end