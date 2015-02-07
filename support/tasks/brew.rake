require "pathname"

def brewfile
  Pathname.new("Brewfile")
end

namespace :brew do
  desc "Install homebrew packages"
  task :bundle do
    raise "Cannot find Brewfile in current directory" unless brewfile.exist?

    brewfile.readlines.each_with_index do |line, index|
      command = line.chomp
      next if command.empty? || command.start_with?("#")
      brew_cmd = "brew #{command}"
      puts "Command failed: L#{index+1}:#{brew_cmd}" unless system brew_cmd
    end
  end
end

