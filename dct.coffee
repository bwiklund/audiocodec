# hello


toDct = (xs) ->
  N = xs.length
  dct = for n in [0...N]
    w = 0
    coef = if n == 0 then Math.sqrt(1 / N) else Math.sqrt(2 / N)
    for x, i in xs
      w += x * coef * Math.cos (2*i+1)*Math.PI*n / (2*N)

    w 




fromDct = (xs) ->
  N = xs.length
  res = for i in [0...N]
    x = 0
    coef = if n == 0 then Math.sqrt(1 / N) else Math.sqrt(2 / N)
    for w, n in xs
      x += w * coef * Math.cos (2*i+1)*Math.PI*n / (2*N)
    x*1



module.exports = {toDct,fromDct}