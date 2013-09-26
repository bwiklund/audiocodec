fs = require 'fs'
DCT = require './dct'
_ = require 'underscore'
ProgressBar = require 'progress'
argv = require('optimist')
  .usage("Usage: $0 -c [chunksize] -q [quality] -f [file]")
  .demand(['f'])
  .default('c',64)
  .default('q',0.5)
  .argv




class Encoder
  constructor: (@settings) ->

  makeProgressBar: (label) ->
    new ProgressBar label + '[:bar] :etas', 
      total: @input.length
      width: 20

  process: ->
    @songBytes = fs.readFileSync @settings.file

    @input = for i in [0...@songBytes.length/4]
      @songBytes.readFloatLE(i*4)

    dctProgressBar      = @makeProgressBar 'calculating DCT '
    compressProgressBar = @makeProgressBar 'compressing     '
    decodingProgressBar = @makeProgressBar 'decoding        '

    toChunks = (size,xs) ->
      for x in [0..xs.length] by size
        xs[x...x+size]

    processChunk = (chunk) ->
      dctProgressBar.tick chunk.length
      DCT.toDct chunk

    compress = (chunk) =>
      compressProgressBar.tick chunk.length
      DCT.toLossyDct chunk, @settings.quality

    decode = (chunk) ->
      decodingProgressBar.tick chunk.length
      DCT.fromDct chunk

    # what is this, haskell?
    @output = _.flatten toChunks( @settings.chunksize, @input )
          .map( processChunk )
          .map( compress )
          .map( decode )




class Player
  constructor: (@samples) ->

    Readable = require('stream').Readable;
    Speaker = require('speaker')

    readable = new Readable
    readable.bitDepth = 16
    readable.channels = 1
    readable.sampleRate = 44100
    readable.samplesGenerated = 0;

    self = @

    readable._read = (n) ->
      buf = new Buffer n*2
      amp = 32760 # max for 16 bit audio

      for i in [0...n]
        sample = ~~ (self.samples[ @samplesGenerated+i ] * amp / 2)
        buf.writeInt16LE( sample, i*2 )

      @samplesGenerated += n

      @push buf

      if self.samples.length < @samplesGenerated
        process.nextTick(this.emit.bind(this, 'end'))

    readable.pipe new Speaker




encoder = new Encoder
  file:      ""+argv.f
  chunksize: parseInt argv.c
  quality:   parseFloat argv.q

encoder.process()

console.log "playing"

new Player encoder.output

