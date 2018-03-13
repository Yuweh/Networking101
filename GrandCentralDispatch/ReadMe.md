
## What is GCD or Grand Central Dispatch ?

Grand Central Dispatch (GCD) is a technology developed by Apple Inc. to optimize application support for systems with multi-core processors and other symmetric multiprocessing systems. It is an implementation of task parallelism based on the thread pool pattern. 


## What is Concurrency

In iOS a process or application is made up of one or more threads. The threads are managed independently by the operating system scheduler. Each thread can execute concurrently but it’s up to the system to decide if this happens and how it happens.


## What are Queues?

GCD provides dispatch queues represented by DispatchQueue to manage tasks you submit and execute them in a FIFO order guaranteeing that the first task submitted is the first one started.

Dispatch queues are thread-safe which means that you can access them from multiple threads simultaneously. The benefits of GCD are apparent when you understand how dispatch queues provide thread safety to parts of your own code. The key to this is to choose the right kind of dispatch queue and the right dispatching function to submit your work to the queue.

### Serial Queues

Serial queues guarantee that only one task runs at any given time. GCD controls the execution timing. You won’t know the amount of time between one task ending and the next one beginning:

###

//to be continued ...

