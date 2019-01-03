require_relative '../lib/image.rb'


img = ImageManipulator.new('../IronMonkey.png')

img.encode('Random message')

img.decode_message
