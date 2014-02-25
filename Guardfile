# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :shell do
  watch(/src\/.*\.(sass|haml|scss|js|json)$/) do
    `./build`
    puts "built"
  end
end
