require_relative './canvas'

class BitmapEditor

  attr_accessor :canvas

  def run(file)
    if file.nil? || !File.exists?(file)
      return puts "please provide correct file"
    end

    File.open(file).each do |line|
      line = line.chomp
      case line
      when /\AI .*\z/
        return unless parse_cmd_I(line)
      when /\AC/
        return unless parse_cmd_C(line)
      when /\AS/
        return unless parse_cmd_S(line)
      when /\AL/
        return unless parse_cmd_L(line)
      else
        puts "unrecognised command :("
      end
    end
  end

  def parse_cmd_L(line)
    if self.canvas.nil?
      puts "There is no image"
      return false
    end

    match, x, y, color = line.match(/\AL (\d+) (\d+) ([A-Z])\z/).to_a
    if match.nil?
      puts "Invalid arguments for L the command takes a coordinate of " +
        "2 integers and color in the range from A to Z"
      return false
    end

    if @canvas.color_pixel(x.to_i, y.to_i, color)
      return true
    else
      puts @canvas.error
      return false
    end
  end

  def parse_cmd_S(line)
    if self.canvas.nil?
      puts "There is no image"
      return false
    end

    unless line.match(/\AS\z/)
      puts "S has no arguments"
      return false
    end

    puts self.canvas.to_s
    return true
  end

  def parse_cmd_C(line)
    if self.canvas.nil?
      puts "There is no image"
      return false
    end

    if line.match(/\AC.+\z/)
      puts "C has no arguments"
      return false
    end

    self.canvas.clear!
    return true
  end

  def parse_cmd_I(line)
    unless line.match(/\AI \d+ \d+\z/)
      puts "Command I got non integer arguments"
      return false
    end
    _, x, y = line.split(' ')
    columns = x.to_i
    rows = y.to_i

    if rows > 250 || rows < 1
      puts "Rows value must be between 1 and 250"
      return false
    end

    if columns > 250 || columns < 1
      puts "Columns value must be between 1 and 250"
      return false
    end

    self.canvas = Canvas.new(columns.to_i, rows.to_i)
    return true
  end

end
