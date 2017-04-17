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
    if x_out_of_range?(x) || y_out_of_range?(y)
      self.error = "Out of image area."
      return false
    end

    unless Colors.validate(color)
      self.error = "Unknown color."
      return false
    end

    self.image[y-1][x-1] = color
    return true
  end

  def vertical_line(x, y1, y2, color)
    return draw_line(x, y1, y2, color, :x)
  end

  def horizontal_line(x1, x2, y, color)
    return draw_line(y, x1, x2, color, :y)
  end

  private

  def draw_line(a, b1, b2, color, a_is)
    if (a_is == :x &&
        (x_out_of_range?(a) || y_out_of_range?(b1) || y_out_of_range?(b2))) ||
       (a_is == :y &&
        (y_out_of_range?(a) || x_out_of_range?(b1) || x_out_of_range?(b2)))

      self.error = "Out of image area."
      return false
    end

    unless Colors.validate(color)
      self.error = "Unknown color."
      return false
    end

    if b1 > b2
      b1, b2 = b2, b1
    end

    (b1..b2).to_a.each do |b|
      if a_is == :x
        self.color_pixel(a, b, color)
      else
        self.color_pixel(b, a, color)
      end
    end
    return true
  end

  def get_clear_image(columns, rows)
    Array.new(rows) { Array.new(columns) { Colors.white } }
  end

  def x_out_of_range?(x)
    return x > self.column_size || x <= 0
  end

  def y_out_of_range?(y)
    return y > self.row_size || y <= 0
  end
end
