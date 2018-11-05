
require 'rspec'
require_relative '../lib/image.rb'

# CONVERSION TO BINARY:


describe 'Conversion to binary' do
  subject(:image) {image = ChunkyPNG::Image.from_file('../PNG-image.png')}

  it 'loads image from file' do
    expect(image.class).to eq(ChunkyPNG::Image)
  end

  it 'extracts pixels into arr of colorvals' do
    expect(image.pixels).to all( be_a(Fixnum))
  end

  it 'converts colorvals to nested arr of rgba' do
    
  end

  it 'converts rgba to bits' do

  end


end

describe 'ENCODING' do

  it 'converts image to nested arr of string of binary' do

  end

  it 'only modifies the required pixels' do

  end

  it 'modifies image pixels after encoding' do

  end

end

describe 'DECODING' do

  it 'converts text provided to binary' do

  end

  it 'extracts required least significant bits from image' do

  end

  it 'correctly returns recovered bits in text' do

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
