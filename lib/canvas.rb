class Canvas

  attr_accessor :image

  def initialize(columns, rows)
    self.image = Array.new(rows) { Array.new(columns) }
  end

  def row_size
    return image.size
  end

  def column_size
    return image[0].size
  end

end
