require 'chunky_png'

image = ChunkyPNG::Image.from_file('PNG-image.png')

# puts image[0,0]
# color = ChunkyPNG::Color.to_hex(image[50,50])
#

color_values = image.pixels


rgba_values = color_values.map do |colorval|
    ChunkyPNG::Color.to_truecolor_alpha_bytes(colorval)
end


bits = rgba_values.map do |pixel|
  pixel.map{|rgba| rgba.to_s(2)}
end


transparent = rgba_values.select do |pixel|
  pixel[-1] == 0
end


def text_to_binary(text)
  text.unpack("B*")[0]
end


def binary_to_text(binary)
  binary.pack("B*")
end


def encode(bits, text)
  message_in_bits = text_to_binary(text)

  i = 0

  while  i <= message_in_bits.length
# what if the number of bits in message is less than, greater than 3, it won't add the entire message

    mask_r_val = message_in_bits[i]
    mask_g_val = message_in_bits[i + 1]
    mask_b_val = message_in_bits[i + 2]

# incase mask val is nil it won't modify it
    bits[i][0][-1] = mask_r_val || bits[i][0][-1]
    bits[i][1][-1] = mask_g_val || bits[i][1][-1]
    bits[i][2][-1] = mask_b_val || bits[i][2][-1]

    # bits[i][0][-1] = message_in_bits[i]
    print [message_in_bits[i + 2], bits[i][2]]

    i += 3
  end

end




encode(bits, "abc")







# puts bits[0][0][-1]

# Each pixel is made up of 4 bytes (R,G,B,A), each of which are made up of 8 bits
# in bits, each sub array is one pixel, or 4 bytes
# so if we only edited the first byte's least significant bit, we would be able to fit a file which had
# the same number of bits as there are pixels or a file 1/4th the size
# bits[0] => The first level deep in bits is a single pixel in the form of an array
# bits[0][0] => the second level is the r values stored as strings
# bits[0][0][-1] => the next level deep is the actualy binary
# to start, only focus on the r values this way you don't have to keep track of the location of each modified pixel
# bits[0]
