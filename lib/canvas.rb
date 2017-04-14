require 'colors'

class Canvas

  attr_accessor :image

  def initialize(columns, rows)
    self.image = get_clear_image(columns, rows)
  end

  def row_size
    return image.size
  end

  def column_size
    return image[0].size
  end

  def color_at(x,y)
    return image[y][x]
  end

  def clear!
    self.image = get_clear_image(column_size, row_size)
  end

  def get_clear_image(columns, rows)
    Array.new(rows) { Array.new(columns) { Colors.white } }
  end
end
