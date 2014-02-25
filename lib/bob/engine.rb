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
    compile_js
    compile_html
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

  def compile_js
    locales = load_locales
    @config.platforms.each do |platform|
      output = locales.dup

      ["lib", "."].each do |folder|
        Dir[File.join("src/javascripts", folder, "/*.js")].each do |file|
          puts "including #{file}"
          js = File.read(file)
          output << ERB.new(js).result(platform.binding) + "\n"
        end
      end
      f = File.open(platform.output_js_file, "w+")
      f.write(output)
      f.close
    end
  end

  def compile_html
    @config.platforms.each do |platform|
      f = File.open(platform.output_html_file, "w+")
      f.write(platform.render)
      f.close
    end
  end

  def load_locales
    locales = {}
    Dir[File.join("src/locales/*.json")].each do |file|
      lang = file.split("/")[-1][0..-6]
      locales[lang] = {}
      locales[lang]["translation"] = JSON.parse(File.read(file))
    end
    "var preloadedLocales = #{locales.to_json};\n\n"
  end
end