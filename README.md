# ruby-zeus-bug
Minimum reproducible example of ruby hanging when run with zeus

## To reproduce

Run the following with Ruby 3.0 or higher
```
bundle install
zeus start
```

As you can see the `default_bundle` task gets stuck (it never becomes green)

# Debugging
Getting strace output for multiple different ruby versions
```bash
strace -v -s 128 -f  zeus start 2> zeus-strace-3.1.0.txt
```

End of Ruby 3.1.0 `strace` output:
```strace
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/number_conversion.rb", iov_len=115}, {iov_base="\n", iov_len=1}], 2) = 116
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/numbered_parameter_assignment.rb", iov_len=127}, {iov_base="\n", iov_len=1}], 2) = 128
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/or_assignment_to_constant.rb", iov_len=123}, {iov_base="\n", iov_len=1}], 2) = 124
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/ordered_magic_comments.rb", iov_len=120}, {iov_base="\n", iov_len=1}], 2) = 121
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/out_of_range_regexp_ref.rb", iov_len=121}, {iov_base="\n", iov_len=1}], 2) = 122
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/parentheses_as_grouped_expression"..., iov_len=131}, {iov_base="\n", iov_len=1}], 2) = 132
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/percent_string_array.rb", iov_len=118}, {iov_base="\n", iov_len=1}], 2) = 119
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/percent_symbol_array.rb", iov_len=118}, {iov_base="\n", iov_len=1}], 2) = 119
[pid 24872] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/raise_exception.rb", iov_len=113}, {iov_base="\n", iov_len=1}], 2) = -1 EAGAIN (Resource temporarily unavailable)
[pid 24872] getpid()                    = 24872
[pid 24872] ppoll([{fd=14, events=POLLOUT}, {fd=7, events=POLLIN}], 2, NULL, NULL, 8 <unfinished ...>
[pid 24859] <... futex resumed> )       = -1 ETIMEDOUT (Connection timed out)
[pid 24859] select(0, NULL, NULL, NULL, {tv_sec=0, tv_usec=20}) = 0 (Timeout)
[pid 24859] futex(0x605f38, FUTEX_WAIT, 0, {tv_sec=60, tv_nsec=0}
```

End of Ruby 3.0.3 `strace` output:
```
[pid 25283] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.0.3/lib/ruby/gems/3.0.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/parentheses_as_grouped_expression"..., iov_len=131}, {iov_base="\n", iov_len=1}], 2) = 132
[pid 25283] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.0.3/lib/ruby/gems/3.0.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/percent_string_array.rb", iov_len=118}, {iov_base="\n", iov_len=1}], 2) = 119
[pid 25283] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.0.3/lib/ruby/gems/3.0.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/percent_symbol_array.rb", iov_len=118}, {iov_base="\n", iov_len=1}], 2) = 119
[pid 25283] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.0.3/lib/ruby/gems/3.0.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/raise_exception.rb", iov_len=113}, {iov_base="\n", iov_len=1}], 2) = 114
[pid 25283] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.0.3/lib/ruby/gems/3.0.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/rand_one.rb", iov_len=106}, {iov_base="\n", iov_len=1}], 2) = 107
[pid 25283] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.0.3/lib/ruby/gems/3.0.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/redundant_cop_disable_directive.r"..., iov_len=129}, {iov_base="\n", iov_len=1}], 2) = 130
[pid 25283] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.0.3/lib/ruby/gems/3.0.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/redundant_cop_enable_directive.rb", iov_len=128}, {iov_base="\n", iov_len=1}], 2) = 129
[pid 25283] writev(14, [{iov_base="/home/jelte/.rbenv/versions/3.0.3/lib/ruby/gems/3.0.0/gems/rubocop-1.23.0/lib/rubocop/cop/lint/redundant_dir_glob_sort.rb", iov_len=121}, {iov_base="\n", iov_len=1}], 2) = -1 EAGAIN (Resource temporarily unavailable)
[pid 25283] getpid()                    = 25283
[pid 25283] ppoll([{fd=14, events=POLLOUT}, {fd=7, events=POLLIN}], 2, NULL, NULL, 8 <unfinished ...>
[pid 25269] <... futex resumed> )       = -1 ETIMEDOUT (Connection timed out)
[pid 25269] select(0, NULL, NULL, NULL, {tv_sec=0, tv_usec=20}) = 0 (Timeout)
[pid 25269] futex(0x605f38, FUTEX_WAIT, 0, {tv_sec=60, tv_nsec=0}
```


Ruby 2.6.9 never gets an EAGAIN on a `writev` (grepped for EAGAIN)
```
11221:[pid 23719] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
11225:[pid 23719] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
11531:[pid 23692] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
11558:[pid 23692] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
11565:[pid 23722] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
11585:[pid 23692] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
11601:[pid 23723] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
11648:[pid 23721] <... futex resumed> )       = -1 EAGAIN (Resource temporarily unavailable)
11689:[pid 23723] <... accept4 resumed> 0xc42003c468, [112], SOCK_CLOEXEC|SOCK_NONBLOCK) = -1 EAGAIN (Resource temporarily unavailable)
11697:[pid 23721] <... recvmsg resumed> {msg_namelen=112}, 0) = -1 EAGAIN (Resource temporarily unavailable)
33218:[pid 23727] futex(0x5645e5494330, FUTEX_WAIT_PRIVATE, 2, NULL) = -1 EAGAIN (Resource temporarily unavailable)
33241:[pid 23725] <... recvmsg resumed> {msg_namelen=112}, 0) = -1 EAGAIN (Resource temporarily unavailable)
33272:[pid 23724] futex(0xc420110110, FUTEX_WAIT, 0, NULL) = -1 EAGAIN (Resource temporarily unavailable)
33410:[pid 23721] <... recvmsg resumed> {msg_namelen=112}, 0) = -1 EAGAIN (Resource temporarily unavailable)
33515:[pid 23718] <... recvmsg resumed> {msg_namelen=112}, 0) = -1 EAGAIN (Resource temporarily unavailable)
```
