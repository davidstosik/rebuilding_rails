# frozen_string_literal: true

require "test_helper"

class DummyController < Rulers::Controller
end

class ControllerTest < Minitest::Test
  def test_controller_name
    assert_equal "dummy", DummyController.new({}).controller_name
  end
end
