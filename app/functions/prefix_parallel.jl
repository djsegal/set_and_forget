function prefix_parallel!(y, +)
  l = length(y)
  k = Int(ceil(log2(l)))

  for m = 0:1 # reduce, then broadcast
    @inbounds for j=get_j(m, k), i=get_i(m, k, l, j)
        y[i] = y[i-2^(j-1)] + y[i]
    end
  end

  y
end

function get_j(m, k)
  j = [1:1:(k-m);]
  if m == 1 ; reverse!(j) ; end
  j
end

function get_i(m, k, l, j)
  istart = (m == 0) ? 2^j : ( 3 * 2^(j-1) )
  i = istart : 2^j : min(l, 2^k)
  i
end
