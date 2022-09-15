# frozen_string_literal: true

require "erubis"

module Rulers
  class Controller
    def initialize(env)
      @env = env
    end

    def render(view_name, locals = {})
      filename = File.join("app", "views", "#{view_name}.html.erb")
      template = File.read(filename)
      eruby = Erubis::Eruby.new(template)
      eruby.result(locals.merge(env: env))
    end

    def controller_name
      self
        .class
        .to_s
        .delete_suffix("Controller")
        .underscore
    end

    private

    attr_reader :env
  end
end
