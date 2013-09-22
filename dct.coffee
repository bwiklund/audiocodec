# hello


toDct = (xs) ->
  N = xs.length
  dct = for n in [0...N]
    w = 0
    for x, i in xs
      w += Math.sqrt(1 / N) * x * Math.cos (2*i+1)*Math.PI*n / (2*N)

    w 




fromDct = (dct) ->
  N = xs.length
  res = for k in [0...N]
    x = 0
    for w, i in dct
      x += w * Math.sqrt(1 / N) * x * Math.cos (2*i+1)*Math.PI*n / (2*N)
    x


#console.log fromDct toDct input


module.exports = {toDct,fromDct}