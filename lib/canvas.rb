require 'colors'

class Canvas

  attr_accessor :image

  def initialize(columns, rows)
    self.image = Array.new(rows) { Array.new(columns) { Colors.white } }
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

end
