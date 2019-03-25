require_relative '../lib/image.rb'


# img = ImageManipulator.new('image-hide-n-seek.s3.amazonaws.com/posts/images/000/000/075/original/img8.png')
img = ImageManipulator.new('../png1.png')

img.encode("no message yet")
# img.decode_message
