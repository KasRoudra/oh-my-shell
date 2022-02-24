function fish_right_prompt
  set -l exit_code $status
  if test $exit_code -ne 0
    set_color red
  else
    set_color green
  end
  if test $exit_code -ne 0
   printf '%d > ' $exit_code.
  end
  set_color yellow
  printf ' %s' (date +%r)
  set_color normal
end
