# Rakefile for dotfiles

tasks = File.expand_path("../support/tasks/*.rake", __FILE__)
Dir.glob(tasks).each do |task|
  load task
end

task default: ["dotfiles:setup"]

