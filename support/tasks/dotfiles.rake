IGNORE_FILES = [".git", ".gitignore", ".gitmodules"]

def home
  File.expand_path "~"
end

def dotfiles_home
  File.expand_path("../../..", __FILE__)
end

def dotfiles(ignore_files = IGNORE_FILES)
  ignores = ignore_files.map {|file| File.join(dotfiles_home, file) }
  Dir.glob(File.join(dotfiles_home, ".[a-z]*")) - ignores
end

def symlink_path(dotfile)
  File.join home, File.basename(dotfile)
end

def create_symlink(src, dest = nil)
  source_check src
  symlink = dest ? dest : symlink_path(src)

  overwrite_confirmed symlink_path(src) do |exists|
    FileUtils.rm symlink, verbose: true if exists
    FileUtils.ln_s src, symlink, verbose: true
  end
end

def copy(src, dest)
  source_check src

  overwrite_confirmed dest do
    FileUtils.cp src, dest, preserve: true, verbose: true
  end
end

def source_check(src)
  raise "#{src} not found!" unless File.exists?(src)
end

def overwrite_confirmed(target, &block)
  execute = false

  if File.exists?(target) || File.symlink?(target)
    # If already exists
    print "#{target} is already exists. overwrite?[yN]"
    overwrite = STDIN.gets.chomp
    if overwrite =~ /^[y|Y]$/
      execute = true
      block.call(true) if block_given?
    end
  else
    execute = true
    block.call(false) if block_given?
  end
  execute
end

namespace :dotfiles do
  desc "Create symlinks of dotfiles"
  task :setup do
    dotfiles.each {|dotfile| create_symlink dotfile }
  end

  desc "Delete symlinks of dotfiles"
  task :destroy do
    dotfiles.each {|dotfile| FileUtils.rm symlink_path(dotfile), verbose: true }
  end
end

