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

    def any_controller_and_action
      controller_name = Object.constants.grep(/Controller$/).first
      raise RoutingError unless controller_name

      controller = Object.const_get(controller_name)
      action = controller.instance_methods(false).first
      raise RoutingError unless action

      [controller, action]
    end
  end
end
