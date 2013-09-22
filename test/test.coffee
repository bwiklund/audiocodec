assert = require('chai').assert

dct = require '../dct'

suite 'dct', ->
  it "is a thing", ->
    assert.deepEqual dct.toDct([1,1]), [Math.sqrt(2), 0]
    assert.deepEqual dct.toDct([1,1,1]), [Math.sqrt(3), 0, 0]