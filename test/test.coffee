chai = require('chai')
chai.use require('chai-stats')
assert = chai.assert


dct = require '../dct'


suite 'dct', ->
  it "is a thing", ->

    vals = [
      [dct.toDct([1,1]), [Math.sqrt(2), 0], 10]
      [dct.toDct([1,1,1]), [Math.sqrt(3), 0, 0]]
      [dct.toDct([1,-1]), [0,1]]
      [dct.toDct([-1,1]), [0,-1]]
    ]

    for val in vals
      assert.deepAlmostEqual  val[0], val[1]
