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
    if x_out_of_range?(x) || y_out_of_range?(y1) || y_out_of_range?(y2)
      self.error = "Out of image area."
      return false
    end

    unless Colors.validate(color)
      self.error = "Unknown color."
      return false
    end

    if y1 > y2
      y1, y2 = y2, y1
    end

    (y1..y2).to_a.each do |y|
      self.color_pixel(x, y, color)
    end
    return true
  end

  private

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
