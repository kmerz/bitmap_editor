require_relative './canvas'

class BitmapEditor

  attr_accessor :canvas

  COMMANDS = [ 'I', 'C', 'S', 'L', 'V', 'H' ]

  def run(file)
    if file.nil? || !File.exists?(file)
      return $stderr.puts "Please provide correct file."
    end

    File.open(file).each do |line|
      line = line.chomp

      cmd = line.split.first
      unless COMMANDS.include?(cmd)
        $stderr.puts "Command not found."
        return
      end

      if self.canvas.nil? && cmd != 'I'
        $stderr.puts "No image initialized yet. Please use command I first."
        return
      end

      return unless self.send("cmd_#{cmd}", line)
    end
  end

  private

  def cmd_H(line)
    match, x1, x2, y, color = line.match(/\AH (\d+) (\d+) (\d+) ([A-Z])\z/).to_a
    if match.nil?
      $stderr.puts "Invalid arguments for H the command takes a coordinate of " +
        "3 positive integers and color in the range from A to Z"
      return false
    end

    if @canvas.horizontal_line(x1.to_i, x2.to_i, y.to_i, color)
      return true
    else
      $stderr.puts @canvas.error
      return false
    end
  end

  def cmd_V(line)
    match, x, y1, y2, color = line.match(/\AV (\d+) (\d+) (\d+) ([A-Z])\z/).to_a
    if match.nil?
      $stderr.puts "Invalid arguments for V the command takes a coordinate of " +
        "3 positive integers and color in the range from A to Z"
      return false
    end

    if @canvas.vertical_line(x.to_i, y1.to_i, y2.to_i, color)
      return true
    else
      $stderr.puts @canvas.error
      return false
    end
  end

  def cmd_L(line)
    match, x, y, color = line.match(/\AL (\d+) (\d+) ([A-Z])\z/).to_a
    if match.nil?
      $stderr.puts "Invalid arguments for L the command takes a coordinate of " +
        "2 positive integers and color in the range from A to Z"
      return false
    end

    if @canvas.color_pixel(x.to_i, y.to_i, color)
      return true
    else
      $stderr.puts @canvas.error
      return false
    end
  end

  def cmd_S(line)
    unless line.match(/\AS\z/)
      $stderr.puts "S has no arguments."
      return false
    end

    puts self.canvas.to_s
    return true
  end

  def cmd_C(line)
    if line.match(/\AC.+\z/)
      $stderr.puts "C has no arguments."
      return false
    end

    self.canvas.clear!
    return true
  end

  def cmd_I(line)
    unless line.match(/\AI \d+ \d+\z/)
      $stderr.puts "Command I got non integer arguments."
      return false
    end
    _, x, y = line.split(' ')
    columns = x.to_i
    rows = y.to_i

    if rows > 250 || rows < 1
      $stderr.puts "Rows value must be between 1 and 250."
      return false
    end

    if columns > 250 || columns < 1
      $stderr.puts "Columns value must be between 1 and 250."
      return false
    end

    self.canvas = Canvas.new(columns.to_i, rows.to_i)
    return true
  end
end
