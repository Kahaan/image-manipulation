require 'chunky_png'

# image = ChunkyPNG::Image.from_file('../PNG-image.png')


class ImageManipulator
  attr_reader :image, :bits

  def initialize(image_path)
    @image_path = image_path
    @image = ChunkyPNG::Image.from_file(@image_path)
    @copy = @image
    @bits = img_to_binary(@copy)
    # I'm initializing abc only to test the binary to image method
    @abc = binary_to_image(@bits)
  end

  def img_to_binary(image)
    color_values = image.pixels
    rgba_values = color_values.map { |colorval| ChunkyPNG::Color.to_truecolor_alpha_bytes(colorval) }
    bits = rgba_values.map { |pixel| pixel.map{|rgba| rgba.to_s(2)} }
    puts bits[0][0]
    return bits
  end

  def binary_to_image(binary)
    # modifying the first pixel to test
    binary[0][0] = "10100101"
    # I'm trying to modify a pixel, convert the binary to a canvas, canvas to image, then convert back to binary and see if the pixel val has been changed
    rgba = binary.map { |pixel| pixel.map{|bin| bin.to_i(2)}}
    color_vals = rgba.map{ |rgba| ChunkyPNG::Color.rgba(*rgba)}
    # print color_vals.class
    # rgba = binary.map { |pixel| Color.rgba(*pixel)} }

    canvas = ChunkyPNG::Canvas.new(@image.width, @image.height, color_vals)
    # rgba is the stream being fed in, it has to be in string format per the documentation
    # rgba = rgba.join("")
    # canvas = ChunkyPNG::Canvas.from_rgba_stream(@image.width,@image.height,rgba)
     # canvas = Canvas.new(@image.width, @image.height, Color.rgba())
    img2 = canvas.to_image
    # When I convert the image back to binary and then check the first pixel to see if it was modified, it isn't :/
    puts back_to_binary = img_to_binary(img2)[0][0]
    # Why didn't the above line return "00100101" ?
    # img2.save('../encoded_pic.png')
    # canvas.save('../encoded_canvas_pic.png')
  end

  def text_to_binary(text)
    text.unpack("B*")[0]
  end

  def binary_to_text(binary)
    binary.pack("B*")
  end


  def encode(text)
    raise "text cannot be empty" if text == ''
    raise "file too large" if text_to_binary(text).length > image.pixels.count * 3

    message_in_bits = text_to_binary(text)

    i = 0
    j = 0
    count = 0
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
      count += 3
    end
# What if the count of bits edited is greater than 255?
    # @bits[-1][0] = count.to_s(2)
    # print binary_to_image(@bits)


    # print img_to_binary(@copy)[-1]
    # @bits.save(File.open("../encoded_pic.png", 'w+'))
  end

  def decode_message(encoded_image_path="../encoded_pic.png")
    encoded_image = ChunkyPNG::Image.from_file(encoded_image_path)
    encoded_bits = img_to_binary(encoded_image)
    puts length_of_text = encoded_bits[-1]
    # length_of_text = text_to_binary(text).length
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
      # puts message_in_binary
      puts binary_to_text(message_in_binary)
  end

end


img = ImageManipulator.new('../PNG-image.png')
# puts binary_to_image(img.bits)
# img.encode("send nudes")
# img.decode_message("../encoded_pic.png")






# Each pixel is made up of 4 bytes (R,G,B,A), each of which are made up of 8 bits
# in bits, each sub array is one pixel, or 4 bytes
# so if we only edited the first byte's least significant bit, we would be able to fit a file which had
# the same number of bits as there are pixels or a file 1/4th the size
# bits[0] => The first level deep in bits is a single pixel in the form of an array
# bits[0][0] => the second level is the r values stored as strings
# bits[0][0][-1] => the next level deep is the actualy binary
# to start, only focus on the r values this way you don't have to keep track of the location of each modified pixel
# bits[0]
