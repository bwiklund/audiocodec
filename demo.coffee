fs = require 'fs'
DCT = require './dct'
_ = require 'underscore'
argv = require('optimist')
  .usage("Usage: $0 -c [chunksize] -q [quality] -f [file]")
  .demand(['f'])
  .default('c',64)
  .default('q',0.5)
  .argv







class Encoder
  constructor: (@settings) ->

  process: ->
    @songBytes = fs.readFileSync @settings.file
    @input = for i in [0...500000]#songBytes.length/4]
      @songBytes.readFloatLE(i*4)




    # convert the buffer to blocks, process each block, and recombine

    toChunks = (size,xs) ->
      for x in [0..xs.length] by size
        xs[x...x+size]

    processChunk = (chunk) ->
      # console.log()
      DCT.toDct chunk



    console.log "processing..."

    # what is this, haskell?
    @output = _.flatten toChunks( @settings.chunksize, @input )
          .map( DCT.toDct )
          .map( (dct) => DCT.toLossyDct dct, @settings.quality )

    console.log "done processing"



encoder = new Encoder
  file:      ""+argv.f
  chunksize: parseInt argv.c
  quality:   parseFloat argv.q


encoder.process()

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
    sample = ~~ (encoder.output[ @samplesGenerated+i ] * amp / 2)
    buf.writeInt16LE( sample, i*2 )

  @samplesGenerated += n

  @push buf


readable.pipe new Speaker

