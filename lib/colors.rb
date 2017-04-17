class Colors
  COLOR_MAP = {
    :white => 'O'
  }

  COLOR_RANGE = ("A".."Z").to_a

  def self.method_missing(method_name, *arguments, &block)
    if self.know_color?(method_name.to_sym)
      COLOR_MAP[method_name.to_sym]
    else
      super
    end
  end

  def self.respond_to_missing?(method_name, include_private = false)
   self.know_color?(method_name.to_sym) || super
  end

  def self.know_color?(color)
    COLOR_MAP.keys.include?(color)
  end

  def self.validate(color)
    return COLOR_RANGE.include?(color)
  end

end
