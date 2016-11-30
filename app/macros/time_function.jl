macro time_function(n_run, cur_function)
  :(
    median(
      [
        (
          tic();
          $cur_function;
          toq();
        )
        for i=1:$n_run
      ]
    )
  )
end
