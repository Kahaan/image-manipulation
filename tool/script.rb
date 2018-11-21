require_relative '../lib/image.rb'


img = ImageManipulator.new('../IronMonkey.png')
#
img.encode("Old macdonald had a farm, E-I-E-I-O", '../abcd.png')
#
img.decode_message('../abcd.png')
