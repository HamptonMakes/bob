# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :shell do
  watch(/.*\.(sass|haml|scss|js)$/) do
    `./build`
    puts "built"
  end
end
