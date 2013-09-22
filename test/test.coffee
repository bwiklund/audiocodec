chai = require('chai')
chai.use require('chai-stats')
assert = chai.assert


dct = require '../dct'


suite 'dct', ->
  it "is a thing", ->

    vals = [
      [[1,1], [Math.sqrt(2), 0], 10]
      [[1,1,1], [Math.sqrt(3), 0, 0]]
      [[1,-1], [0,1]]
      [[-1,1], [0,-1]]
    ]

    for val in vals
      assert.deepAlmostEqual dct.toDct(val[0]), val[1]
      # assert.deepAlmostEqual val[1], val[0]
