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
        unless line.match(/\AI \d+ \d+\z/)
          puts "Command I got non integer arguments"
          return
        end
        _, x, y = line.split(' ')
        @canvas = Canvas.new(x.to_i, y.to_i)
        puts "Create a new image of #{x} x #{y}"
      when 'S'
        puts "There is no image"
      else
        puts "unrecognised command :("
      end
    end
  end

end
