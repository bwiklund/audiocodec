fs = require 'fs'
DCT = require './dct'
baudio = require 'baudio'

songBytes = fs.readFileSync 'out.raw'

#16 bit le
song = []
for i in [0..900000]
  song.push parseFloat songBytes.readFloatLE(i*4)

input = song

sliceLength = 16
slices = for x in [0..input.length / sliceLength]
  input[sliceLength*x...sliceLength*(x+1)]

dcts = slices.map DCT.toDct

dcts = dcts.map (dct) -> DCT.toLossyDct dct, 0.2

outputSlices = dcts.map DCT.fromDct

output = [].concat.apply [], outputSlices


# n = 0
# b = baudio (t,i) -> output[i]

# b.play()

process.stdin.resume()

Readable = require('stream').Readable;
Speaker = require('speaker')


readable = new Readable
readable.bitDepth = 16
readable.channels = 1
readable.sampleRate = 44100
readable.samplesGenerated = 0;
readable._read = (n) ->
  buf = new Buffer n*2
  amp = 32760 # max for 16 bit audio

  for i in [0...n]
    sample = song[ @samplesGenerated+i ] * amp
    buf.writeInt16LE( sample, i*2 )

  @samplesGenerated += n

  @push buf


readable.pipe new Speaker

