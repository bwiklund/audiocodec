# hello

input = [1,1,1,1]

toDct = (xs) ->
  dct = for k in [0...xs.length]
    w = 0
    for x, i in xs
      w += x * Math.cos(i*(Math.PI/xs.length/2)*k)
    w /= xs.length

    # remove that from the signal?
    for x, i in xs
      xs[i] -= w * Math.cos(i*(Math.PI/xs.length/2)*k)

    w *= Math.sqrt(xs.length)




fromDct = (dct) ->
  res = for k in [0...dct.length]
    x = 0
    for w, i in dct
      x += w * Math.cos(i*(Math.PI/dct.length*2)*k)
    x



console.log toDct input

#console.log fromDct toDct input


module.exports = {toDct}