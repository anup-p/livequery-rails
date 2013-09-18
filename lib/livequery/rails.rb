require 'rails'
require 'livequery/assert_select' if ::Rails.env.test?
require 'livequery/rails/engine' if ::Rails.version >= '3.1'
require 'livequery/rails/railtie'
require 'livequery/rails/version'

module Livequery
  module Rails
  end
end