
require 'json'
require_relative 'platform'

class Bob::Config
  attr :data
  attr :platforms

  def self.load
    json = File.read('config.json')
    config = JSON.parse(json)
    self.new(config)
  end

  def initialize(data = {})
    @data = data
    @platforms = data.map do |name, config|
      Bob::Platform.new(name, config)
    end
  end
end