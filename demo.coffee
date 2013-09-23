fs = require 'fs'
DCT = require './dct'

songBytes = fs.readFileSync 'out.raw'

#16 bit le
song = []
for i in [0..900000]
  song.push parseFloat songBytes.readFloatLE(i*4)

input = song

# convert the buffer to blocks, process each block, and recombine

toChunks = (size,xs) ->
  for x in [0..xs.length] by size
    xs[x...x+size]

unChunks = (xs) -> [].concat.apply [], xs

# what is this, haskell?
output = unChunks toChunks( 16, input )
      .map( DCT.toDct )
      .map( (dct) -> DCT.toLossyDct dct, 0.2 )
      .map( DCT.fromDct )


Readable = require('stream').Readable;
Speaker = require('speaker')





##################### audio cruft ########################

readable = new Readable
readable.bitDepth = 16
readable.channels = 1
readable.sampleRate = 44100
readable.samplesGenerated = 0;
readable._read = (n) ->
  buf = new Buffer n*2
  amp = 32760 # max for 16 bit audio

  for i in [0...n]
    sample = ~~ (output[ @samplesGenerated+i ] * amp)
    buf.writeInt16LE( sample, i*2 )

  @samplesGenerated += n

  @push buf


readable.pipe new Speaker

