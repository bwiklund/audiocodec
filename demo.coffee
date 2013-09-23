fs = require 'fs'
DCT = require './dct'
baudio = require 'baudio'

songBytes = fs.readFileSync 'out.raw'

#16 bit le
song = []
for i in [100000..900000]
  song.push parseFloat songBytes.readFloatLE(i*4)

input = song

sliceLength = 16
slices = for x in [0..input.length / sliceLength]
  input[sliceLength*x...sliceLength*(x+1)]

dcts = slices.map DCT.toDct

dcts = dcts.map (dct) -> DCT.toLossyDct dct, 0.2

outputSlices = dcts.map DCT.fromDct

output = [].concat.apply [], outputSlices


n = 0
b = baudio (t,i) -> output[i]

b.play()
