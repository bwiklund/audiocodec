chai = require('chai')
chai.use require('chai-stats')
assert = chai.assert


dct = require '../dct'


suite 'dct', ->

  vals = [
    [0,0]
    [1,1]
    [1,1,1]
    [1,1,1,1]
    [1,-1]
    [2,-2]
    [-1,1]
    [0,0,0]
    [0,1,0]
    [1,1,1]
    [1,1,1,1]
    Math.random()-0.5 for i in [0..100]
  ]

  for val in vals 
    do (val) ->
      # it "forward #{val[0]} -> #{val[1]}", ->
      #   console.log dct.toDct(val[0]), val[1]
      #   assert.deepAlmostEqual dct.toDct(val[0]), val[1], 8
      # it "inverse #{val[1]} -> #{val[0]}", ->
      #   console.log dct.fromDct(val[1]), val[0]
      #   assert.deepAlmostEqual dct.fromDct(val[1]), val[0], 8
      it "it!", ->
        assert.deepAlmostEqual dct.fromDct(dct.toDct(val)), val, 8
