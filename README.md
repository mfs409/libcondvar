libcondvar
---------

This repository stores a userspace implementation of condition variables that
is mostly compatible with pthread_cond_t.  It is also transaction-safe, but
there are some restrictions on how to use it in transactions.
