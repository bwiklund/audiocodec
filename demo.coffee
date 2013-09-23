DCT = require './dct'
baudio = require 'baudio'


input = (Math.random() - 0.5 for i in [0..100000])

sliceLength = 100
slices = for x in [0..input.length / sliceLength]
  input[sliceLength*x...sliceLength*(x+1)]

dcts = slices.map DCT.toDct

outputSlices = dcts.map DCT.fromDct
# dct = DCT.toDct input

# dct = DCT.toLossyDct dct, 0.4
output = [].concat.apply [], outputSlices




n = 0
b = baudio (t) ->
  if output.length == 0
    setTimeout (-> process.exit() ), 100
    return 0
  return output.pop()

b.play()
