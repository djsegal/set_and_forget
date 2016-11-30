macro setup_procs()
  [
    f([randn(3,3) for i=1:2], *)
    for f in (prefix_serial!, prefix_parallel!)
  ]

  quote
    r = [
      @spawnat p randn(n,n)
      for p in procs()[1:nprocs()]
    ]

    s = fetch(r) #These are in-memory matrices

    r, s
  end
end

