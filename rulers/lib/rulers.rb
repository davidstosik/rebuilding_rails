# frozen_string_literal: true

require_relative "rulers/version"
require "rulers/array"
require "rulers/object"

require "rulers/routing"

module Rulers
  class Application
    def call(env)
      controller_class, action = begin
        get_controller_and_action(env)
      rescue RoutingError
        return [404, { "Content-Type" => "text/html" }, ["Not Found"]]
      end

      text = controller_class.new(env).send(action)

      [200, { "Content-Type" => "text/html" }, [text]]
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
