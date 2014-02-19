require 'sass'
require 'fileutils'

class Bob::Engine
  def initialize(config)
    @config = config
  end

  def run
    make_directories
    compile_sass
    copy_assets
    compile_platforms
  end

  def make_directories
    @config.platforms.each do |platform|
      if File.exists?(platform.output_folder)
        FileUtils.rm_rf(platform.output_folder)
      end
      Dir.mkdir(platform.output_folder)
    end
  end

  def compile_sass
    @config.platforms.each do |platform|
      file = File.join("src/stylesheets", platform.input_sass_file + ".scss")
      sass = Sass::Engine.for_file(file, {})
      f = File.open(platform.output_sass_file, "w+")
      f.write(sass.render)
      f.close
    end
  end

  def copy_assets
    @config.platforms.each do |platform|
      platform.assets.each do |asset_folder|
        FileUtils.cp_r(File.join("src", asset_folder), platform.output_folder)
      end
    end
  end

  def compile_platforms
    @config.platforms.each do |platform|
      f = File.open(platform.output_html_file, "w+")
      f.write(platform.render)
      f.close
    end
  end
end