require 'chunky_png'

image = ChunkyPNG::Image.from_file('PNG-image.png')

puts "loaded"

image[0,0] = ChunkyPNG::Color.rgba(255,0,0,128)
image.line(1,1,10,1 ,ChunkyPNG::Color.from_hex('#aa007f'))
new_image = image.flip_horizontally.rotate_right
image.compose(ChunkyPNG::Image.new(16,16,ChunkyPNG::Color.rgba(10,10,10, 128)))
image.save('PNG-image.png')
