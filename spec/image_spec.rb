
require 'rspec'
require_relative '../lib/sample.rb'

# CONVERSION TO BINARY:

# Check image is in PNG format
# Check that the same bits object is being modified throughout
describe Image do
  # subject(:image) {image = ChunkyPNG::Image.from_file('../PNG-image.png')}
  subject(:img) {Image.new}

  context '#initialize' do
    it 'loads image from file' do
      expect(img.image.class).to eq(ChunkyPNG::Image)
    end
  end

  context '#img_to_binary' do
    it 'converts image to nested arr of string of binary' do
      expect(img.bits.flatten).to all( be_a(String))
    end

    it 'converts image to binary' do
      expect(img.bits.flatten.all?{|bit| bit == "1" || bit == "0"})
    end
  end

  context '#encoding' do
    let(:test_img) {Image.new}
    it 'modifies image pixels after encoding' do
      bits = img.encode("abc")
      test_bits = test_img.bits
      expect(bits).to_not eq(test_bits)
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
