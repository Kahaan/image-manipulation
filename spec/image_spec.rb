
require 'rspec'
require_relative '../lib/sample.rb'

# CONVERSION TO BINARY:

# Check image is in PNG format

describe Image do
  subject(:image) {image = ChunkyPNG::Image.from_file('../PNG-image.png')}

  context '#initialize' do
    it 'loads image from file' do
      expect(image.class).to eq(ChunkyPNG::Image)
    end
  end

  context '#img_to_binary' do
    it 'extracts pixels into arr of colorvals' do
      expect(image.pixels).to all( be_a(Fixnum))
    end

    it 'converts colorvals to nested arr of rgba' do
      expect(rgba_values).to all( be_a(Array))
    end

    it 'converts rgba to bits' do

    end

    it 'converts image to nested arr of string of binary' do

    end
  end

  context '#encoding' do
    it 'modifies image pixels after encoding' do

    end
  end

  context '#decoding' do
    it 'correctly returns recovered bits in text' do

    end
  end

end

  # check if image has loaded properly
  # check that color_values returns an array of pixels
  # check that rgba_values returns a nested array of rgba_values
  # check bits turns rgba values into binary


# Check that text file is being converted to binary and
# returns a string, NOT array

# Check that binary can be converted back to string

# ENCODING:
  # Check that text message is properly converted to binary
  # Check that image has been modified after
  # Check count of pixels modified to see if only the required
  #   pixels were touched

# DECODING:
  # Check that the length of text in binary is the same
  #   as the results
  # Check the return value is the same as the input text
