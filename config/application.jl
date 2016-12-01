__precompile__()

addprocs( max(0, Sys.CPU_CORES-nprocs()) )

@everywhere module Application

  try
    include("bootload.jl")
  catch
    include("config/bootload.jl")
  end

  function main()
    gc_enable(false)

    r , s = @setup_procs
    n_run = Int( max(1, 5 - floor(n/1000)) )

    t_ser = @time_function n_run        prefix_serial!(  s, *)
    t_par = @time_function n_run @sync( prefix_parallel!(r, *) )

    println( t_ser / t_par )

    gc_enable(true)
  end

end
