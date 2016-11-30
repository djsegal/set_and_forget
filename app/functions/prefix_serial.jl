function prefix_serial!(y, +)
  @inbounds for i=2:length(y)
      y[i] = y[i-1] + y[i]
  end
  y
end
