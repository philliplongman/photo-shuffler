require "fileutils"

# extensions to copy
types = %w(jpg jpeg png tiff bmp gif)
types = (types + types.map(&:upcase)).join(",")

# clear any files from running before
renamed = Dir["renamed/**/*"]
FileUtils.remove renamed

# generate a new shuffled order for the files and rename
files = Dir["original/**/*.{#{types}}"].shuffle

pad = files.count.to_s.length

files.each_with_index do |file, index|
  name = (index + 1).to_s.rjust(pad, "0")
  ext = File.extname(file).downcase
  FileUtils.copy file, File.join("renamed", name + ext)
end

`open ./renamed`
