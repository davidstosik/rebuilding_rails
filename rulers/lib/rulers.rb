# frozen_string_literal: true

require_relative "rulers/version"
require "rulers/array"
require "rulers/object"

require "rulers/routing"

module Rulers
  class Application
    def call(env)
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, { "Content-Type" => "text/html" }, [text]]
    rescue NameError
      [404, { "Content-Type" => "text/html" }, ["Not Found"]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    private

    attr_reader :env
  end
end
