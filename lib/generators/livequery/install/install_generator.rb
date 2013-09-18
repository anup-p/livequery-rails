require 'rails'

# Supply generator for Rails 3.0.x or if asset pipeline is not enabled
if ::Rails.version < "3.1" || !::Rails.application.config.assets.enabled || !File.exist?('app/assets/javascripts/application.js') || !File.exist?('app/assets/javascripts/application.js.coffee')
  module Livequery
    module Generators
      class InstallGenerator < ::Rails::Generators::Base

        desc "This generator installs Livequery #{Livequery::Rails::LIVEQUERY_VERSION}"
        source_root File.expand_path('../../../../../vendor/assets/javascripts', __FILE__)

        def copy_livequery
          say_status("copying", "livequery (#{Livequery::Rails::LIVEQUERY_VERSION})", :green)
          copy_file "livequery.js", "public/javascripts/Livequery.js"
          copy_file "livequery.min.js", "public/javascripts/Livequery.min.js"
        end
      end
    end
  end
else
  module Livequery
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        desc "This generator add Livequery #{Livequery::Rails::LIVEQUERY_VERSION} to application.js or application.js.coffee"
        source_root File.expand_path('../../../../../vendor/assets/javascripts', __FILE__)
        def add_assets
          insert_into_file "app/assets/javascripts/application#{detect_js_format[0]}", "#{detect_js_format[1]} require livequery\n", :after => "jquery_ujs\n"
        end
        
        def detect_js_format
          return ['.js.coffee', '#='] if File.exist?('app/assets/javascripts/application.js.coffee')
          return ['.js', '//='] if File.exist?('app/assets/javascripts/application.js')
        end
      end
    end
  end
end
