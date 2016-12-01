# --------------------
#  check if on worker
# --------------------

is_worker = false
try
  include("input.jl")
catch
  is_worker = true
end

# -------------------
#  load config files
# -------------------

base_dir = is_worker ? "config" : "."

include("$base_dir/input.jl")
include("$base_dir/include_all.jl")
include("$base_dir/export_all_except.jl")

# ------------------
#  import all files
# ------------------

ordered_dirs_included = [
  "vendor", "config/initializers", "lib",
  "app/methods", "app/functions", "app/macros"
]

for included_dir in ordered_dirs_included
  include_all(included_dir, is_worker ? "." : "..")
end

@export_all_except
