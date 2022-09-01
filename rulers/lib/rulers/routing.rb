# frozen_string_literal: true

module Rulers
  class RoutingError < StandardError; end

  class Application
    def get_controller_and_action(env)
      _, cont, action, _after = env["PATH_INFO"].split("/", 4)
      cont.capitalize!
      cont << "Controller"

      begin
        controller = Object.const_get(cont)
        raise RoutingError unless controller.method_defined?(action)
      rescue NameError
        raise RoutingError
      end

      [Object.const_get(cont), action]
    end
  end
end
