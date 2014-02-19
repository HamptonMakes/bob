
require 'bundler/setup'

module Bob
end

require_relative 'bob/config'
require_relative 'bob/engine'

config = Bob::Config.load

engine = Bob::Engine.new(config)
engine.run