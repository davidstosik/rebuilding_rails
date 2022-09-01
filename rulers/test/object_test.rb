# frozen_string_literal: true

require_relative "test_helper"

class ObjectTest < Minitest::Test
  def test_blank?
    assert nil.blank?
    assert "".blank?
    assert [].blank?
    refute "test".blank?
    refute [1].blank?
    refute [""].blank?
  end

  def test_present?
    refute nil.present?
    refute "".present?
    refute [].present?
    assert "test".present?
    assert [1].present?
    assert [""].present?
  end
end
