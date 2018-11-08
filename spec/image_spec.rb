
require 'rspec'
require_relative '../lib/sample.rb'

# CONVERSION TO BINARY:

# Check image is in PNG format
# Check that the same bits object is being modified throughout
describe Image do

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

    it 'raises error if the message is empty string' do
      expect{test_img.encode("")}.to raise_error('text cannot be empty')
    end

    it 'raises error if message is too long' do
      max_bits = test_img.pixels * 3
      expect(test_img.encode(""))
    end
  end

  context '#decoding' do
    it 'correctly returns recovered bits in text' do
      img.encode("abc")
      expect(img.decode_message("abc")).to eq("abc")
    end
  end



end
