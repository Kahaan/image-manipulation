require 'chunky_png'

image = ChunkyPNG::Image.from_file('../PNG-image.png')


class Image

  def initialize
    @image = ChunkyPNG::Image.from_file('../PNG-image.png')
    @bits = img_to_binary
  end

  def img_to_binary
    color_values = @image.pixels
    rgba_values = color_values.map { |colorval| ChunkyPNG::Color.to_truecolor_alpha_bytes(colorval) }
    bits = rgba_values.map { |pixel| pixel.map{|rgba| rgba.to_s(2)} }
  end

  def text_to_binary(text)
    text.unpack("B*")[0]
  end

  def binary_to_text(binary)
    binary.pack("B*")
  end


  def encode(text)
    message_in_bits = text_to_binary(text)

    i = 0
    j = 0
    # puts "#{message_in_bits}:"
    while  i <= message_in_bits.length

      mask_r_val = message_in_bits[i]
      mask_g_val = message_in_bits[i + 1]
      mask_b_val = message_in_bits[i + 2]

      @bits[j][0][-1] = mask_r_val || @bits[i][0][-1]
      @bits[j][1][-1] = mask_g_val || @bits[i][1][-1]
      @bits[j][2][-1] = mask_b_val || @bits[i][2][-1]

      # print @bits[j][0][-1]
      # print @bits[j][1][-1]
      # print @bits[j][2][-1]

      i += 3
      j += 1
    end
    return @bits
  end

  def decode_message(text)

    length_of_text = text_to_binary(text).length
    results = []

      i = 0
      while results.length <= length_of_text
        r_val = @bits[i][0][-1]
        g_val = @bits[i][1][-1]
        b_val = @bits[i][2][-1]

        results << r_val << g_val << b_val

        i += 1
      end

      message_in_binary = [results[0...length_of_text].join("")]
      puts binary_to_text(message_in_binary)
  end

end


img = Image.new
img.encode("send nudes")
img.decode_message("send nudes")






# Each pixel is made up of 4 bytes (R,G,B,A), each of which are made up of 8 bits
# in bits, each sub array is one pixel, or 4 bytes
# so if we only edited the first byte's least significant bit, we would be able to fit a file which had
# the same number of bits as there are pixels or a file 1/4th the size
# bits[0] => The first level deep in bits is a single pixel in the form of an array
# bits[0][0] => the second level is the r values stored as strings
# bits[0][0][-1] => the next level deep is the actualy binary
# to start, only focus on the r values this way you don't have to keep track of the location of each modified pixel
# bits[0]
