class BitmapEditor

  def run(file)
    if file.nil? || !File.exists?(file)
      return puts "please provide correct file"
    end

    File.open(file).each do |line|
      line = line.chomp
      case line
      when 'S'
        puts "There is no image"
      else
        puts "unrecognised command :("
      end
    end
  end

end
