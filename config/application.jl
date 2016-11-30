__precompile__()

addprocs( max(0, Sys.CPU_CORES-nprocs()) )

@everywhere module Application

  is_worker = false
  try
    include("input.jl")
  catch
    is_worker = true
  end
  base_dir = is_worker ? "config" : "."

  include("$base_dir/input.jl")
  include("$base_dir/include_all.jl")
  include("$base_dir/export_all_except.jl")

  ordered_dirs_included = [
    "vendor", "config/initializers", "lib",
    "app/methods", "app/functions", "app/macros"
  ]

  for included_dir in ordered_dirs_included
    include_all(included_dir, is_worker ? "." : "..")
  end
  @export_all_except

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
