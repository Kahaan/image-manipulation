require_relative '../lib/image.rb'


img = ImageManipulator.new('../IronMonkey.png')
#
img.encode("Old macdonald had a farm, E-I-E-I-O", '../xyz.png')
#
img.decode_message('../xyz.png')
