require 'chunky_png'


class ImageManipulator
  attr_reader :image, :bits

  def initialize(image_path)
    # create error if the image_path isnt for a png file
    # crete error if the image_path is blank
    # create error if no image is found at the path
    @image_path = image_path
    @image = ChunkyPNG::Image.from_file(@image_path)
    @copy = @image
    @bits = img_to_binary(@copy)
  end

  def img_to_binary(image)
    color_values = image.pixels
    rgba_values = color_values.map { |colorval| ChunkyPNG::Color.to_truecolor_alpha_bytes(colorval) }
    bits = rgba_values.map { |pixel| pixel.map{|rgba| rgba.to_s(2)} }
    return bits
  end

  def binary_to_image(binary)
    rgba = binary.map { |pixel| pixel.map{|bin| bin.to_i(2)}}
    color_vals = rgba.map{ |rgba| ChunkyPNG::Color.rgba(*rgba)}
    canvas = ChunkyPNG::Canvas.new(@image.width, @image.height, color_vals)
    encoded_img = canvas.to_image
    encoded_img.save('../encoded_pic.png')
  end

  def text_to_binary(text)
    text.unpack("B*")[0]
  end

  def binary_to_text(binary)
    binary.pack("B*")
  end


  def encode(text)
    raise "text cannot be empty" if text == ''
    raise "file too large, enter shorter file or use larger image" if text_to_binary(text).length > image.pixels.count * 3
    text = "'#{text}'"
    message_in_bits = text_to_binary(text)

    i = 0
    j = 0
    count = 0
    # puts "#{message_in_bits}:"
    while  i <= @bits.length

      mask_r_val = message_in_bits[i]
      mask_g_val = message_in_bits[i + 1]
      mask_b_val = message_in_bits[i + 2]

      @bits[j][0][-1] = mask_r_val || "1"
      @bits[j][1][-1] = mask_g_val || "1"
      @bits[j][2][-1] = mask_b_val || "1"

      # print @bits[j][0][-1]
      # print @bits[j][1][-1]
      # print @bits[j][2][-1]

      i += 3
      j += 1
      # count += 3
    end

    binary_to_image(@bits)
  end


  def decode_message(encoded_image_path="../encoded_pic.png")
    # breaks if I use double quotes in the text
    encoded_image = ChunkyPNG::Image.from_file(encoded_image_path)
    encoded_bits = img_to_binary(encoded_image)
    results = []

      i = 0
      while results.length <= encoded_bits.length
        r_val = encoded_bits[i][0][-1]
        g_val = encoded_bits[i][1][-1]
        b_val = encoded_bits[i][2][-1]

        results << r_val << g_val << b_val

        i += 1
      end

      message_in_binary = [results[0..-1].join("")]
      decoded_text = binary_to_text(message_in_binary)
      end_idx = decoded_text.rindex("\'")
      puts decoded_text[1...end_idx]
  end

end

# img = ImageManipulator.new('../PNG-image.png')
img = ImageManipulator.new('../IronMonkey.png')

img.decode_message
