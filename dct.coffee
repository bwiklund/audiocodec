# hello

pi = Math.PI
cos = Math.cos
sqrt = Math.sqrt

basis = (i,n,N) ->
  arg = pi*n*(2*i+1)/(2*N)
  cosine = cos(arg)
  cosine * coef(n) * sqrt(2/N)



coef = (i) ->
  if i == 0 then 1/Math.sqrt(2) else 1


toDct = (xs) ->
  xs = xs.slice 0
  N = xs.length
  dct = for n in [0...N]
    w = 0
    for x, i in xs
      w += x * basis(i,n,N)
    w

  dct




fromDct = (xs) ->
  N = xs.length
  res = for i in [0...N]
    x = 0
    for w, n in xs
      x += w * basis i,n,N
    x





module.exports = {toDct,fromDct}