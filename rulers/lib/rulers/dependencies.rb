# frozen_string_literal: true

class Object
  def self.const_missing(const_name)
    require const_name.to_s.underscore
    if const_defined?(const_name)
      Object.const_get(const_name)
    else
      super
    end
  rescue LoadError
    super
  end
end
