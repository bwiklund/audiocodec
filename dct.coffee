# hello


toDct = (xs) ->
  N = xs.length
  dct = for n in [0...N]
    w = 0
    for x, i in xs
      w += Math.sqrt(1 / N) * x * Math.cos (2*i+1)*Math.PI*n / (2*N)

    w 




# fromDct = (dct) ->
#   res = for k in [0...dct.length]
#     x = 0
#     for w, i in dct
#       x += w * Math.cos(i*(Math.PI/dct.length*2)*k)
#     x


#console.log fromDct toDct input


module.exports = {toDct}