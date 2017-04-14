require 'canvas'

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
        puts "Create a new image of #{self.canvas.column_size} x " +
          "#{self.canvas.row_size}"
      when 'S'
        puts "There is no image"
      else
        puts "unrecognised command :("
      end
    end
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
