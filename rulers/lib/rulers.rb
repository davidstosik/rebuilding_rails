# frozen_string_literal: true

require_relative "rulers/version"

require "rulers/object"
require "rulers/string"
require "rulers/array"
require "rulers/dependencies"

require "rulers/routing"

module Rulers
  class Application
    def call(env)
      if requested_root?(env)
        respond_for_root(env)
      else
        respond(env)
      end
    end

    private

    def requested_root?(env)
      env["PATH_INFO"] == "/"
    end

    def respond_for_root(env)
      text = HomeController.new(env).send(:index)

      [200, { "Content-Type" => "text/html" }, [text]]
    end

    def respond(env)
      controller_class, action = begin
        get_controller_and_action(env)
      rescue RoutingError
        return [404, { "Content-Type" => "text/html" }, ["Not Found"]]
      end

      text = controller_class.new(env).send(action)

      [200, { "Content-Type" => "text/html" }, [text]]
    rescue StandardError => e
      [500, { "Content-Type" => "text" }, ["There was an error: #{e.inspect}"]]
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
