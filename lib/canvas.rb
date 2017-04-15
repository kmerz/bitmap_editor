require_relative './colors'

class Canvas

  attr_accessor :image
  attr_accessor :error

  def initialize(columns, rows)
    self.image = get_clear_image(columns, rows)
  end

  def row_size
    return self.image.size
  end

  def column_size
    return self.image[0].size
  end

  def color_at(x,y)
    return self.image[y][x]
  end

  def clear!
    self.image = get_clear_image(self.column_size, self.row_size)
  end

  def get_clear_image(columns, rows)
    Array.new(rows) { Array.new(columns) { Colors.white } }
  end

  def to_s
    return self.image.reduce("") do |result, row|
      result = row.reduce(result) do |acc, pixel|
        acc += pixel
        acc
      end + "\n"
      result
    end
  end

  def color_pixel(x, y, color)
    if x > self.column_size || x <= 0 || y > self.row_size || y <= 0
      self.error = "Out of image area."
      return false
    end

    self.image[y-1][x-1] = color
    return true
  end
end
