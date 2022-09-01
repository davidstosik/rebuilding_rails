# frozen_string_literal: true

class Object
  def present?
    !blank?
  end

  def blank?
    return true if nil?

    if respond_to?(:empty?)
      empty?
    else
      false
    end
  end
end
