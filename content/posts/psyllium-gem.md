---
title: 'Ruby Fibers and the Psyllium Gem'
date: '2025-03-30T22:22:31-05:00'
lastmod: '2025-03-31T17:33:07-05:00'
Author: Ethan Estrada
aliases: []
tags: [code, ruby]
draft: false
---

So, I created a new Ruby Gem. I had an itch, and nothing else already existed
to scratch it. Details in the rest of this post.

I'm finding that in my free time I'm spending more of my time working with Ruby
as my language of choice. Maybe this is a bit dated; you could perhaps argue
that Ruby already "peaked" and now we should all move onto the hottest new
thing now that friendlier statically typed languages have come out like Golang,
Rust, and Zig.

Regardless, I still find Ruby enjoyable to use. If no one is dictating what
language I need to use, why not use one that I enjoy?

I'll admit I am drawn to the promise of a single compiled executable, like Go
and Zig can do by default. However, for sheer number of libraries and ease of
use, Ruby is still hard to beat.

And if you are running on a server, it isn't hard to horizontally scale servers
to deal with demand. Computer time is cheap, programmer time is expensive. For
the most part it is fine to just throw more computers at a problem like
horizontally scaling a web service. Thus, any performance deficiencies in Ruby
are simple to overcome.

However, it is nice when you can have the best of both worlds. Ruby's Fiber
scheduler holds much promise in this way. It allows lightweight concurrency
without the high memory requirements that native Threads require. This idea is
nothing new. Golang's Goroutines have done this for a long time, abstracting
away the need for the user to know exactly how threads/goroutines juggle
context and scheduling.

Most of the time for a web service is spent waiting; waiting to read from a
socket for an incoming HTTP request, waiting to write to a socket for an
outgoing HTTP response, waiting for IO to/from a database connection, waiting
for IO from disk, waiting for an external process to finish, and so on.
Concurrency primitives like Fibers work great for this.

Some great tools already exist like the Async Fiber Scheduler and the Falcon
web server. These take advantage of the Fiber Scheduler interface and allow a
web service to scale to much higher levels, assuming that the work loads are
not CPU bound.

However, it has been hard to use Fibers in the same way that native Threads can
be used: fire off a thread (or several) and then join the thread object and
retrieve the final result (or exception). This is useful if you need to reach
out to several external resources, for example. By reaching out to them
concurrently you can significantly decrease your response time, since most of
that time will be spent waiting on socket IO anyway. Thus, start multiple
requests simultaneously with Threads and they can all wait for their payloads
at the same time.

I made a new gem to make this easier with Fibers: [the Psyllium
gem](https://rubygems.org/gems/psyllium). It adds `start`, `join`, `value`, and
a few other methods to the Fiber class so that it behaves more like the Thread
class. So now you can have the convenience of the Thread class interface, while
benefiting from the reduced memory usage of the Fiber class.

By my calculation, using Threads to concurrently do IO calculations takes at
least 76 times more memory than using Fibers. That means that if you
simultaneously retrieve 1000 external IO constrained resources with Fibers it
will take around 13 MB of memory. However, using Threads to do the same would
cost around 1000 MB, nearly a gibibyte of memory. This assumes that your
platform _only_ allocates 1 MB of stack memory per native system Thread;
depending on the configuration of your system this can be greater than 1 MB. To
be fair, stack memory per thread could instead be configured to be lower, but
that is ill advised since it is easy to create a stack overflow when stack
memory is so low.

You can, of course, use a Thread pool to cut down on this memory cost. Doing so
will make sure that no more than a handful of Threads exist at a time, thus
ensuring memory usage does not go out of control. However, this comes at a cost
of increased time; you now can no longer start retrieving all of your external
resources simultaneously. Some must wait to be started until prior ones finish
downloading. The Thread pool becomes a bottleneck.

If the main constraint is IO, and the main use of time is spent waiting on that
IO, then you want to get the waiting started as soon as possible. Using Fibers
and spawning all your IO as soon as possible is the ideal choice in this
situation. Using a Thread pool will only slow you down since you cannot start
waiting on all resources immediately. And spawning a Thread for each waited
upon resource eats up huge amounts of memory.

So instead of using Threads or a Thread pool, do this instead:

```ruby
# Adds new methods to Fiber
require 'psyllium'

# Calls to `Fiber.start` will fail if no scheduler is set beforehand.
Fiber.set_scheduler(SomeSchedulerImplementation.new)

fiber1 = Fiber.start { long_running_io_operation_with_result1() }
fiber2 = Fiber.start { long_running_io_operation_with_result2() }

# because we started both fibers before joining them, they both continue to do
# their IO work concurrently, even when we `join` them.
fiber1.join
fiber2.join

# The `status` method from the Thread class is also brought over, so it is
# possible to ask a Fiber about it's status externally in the same way that a
# Thread can be asked. Is it still running? Did it complete? Did it complete
# with an exception?
puts 'fiber1 ended with an exception' if fiber1.status.nil?
puts 'fiber2 ended without an exception' if fiber2.status == false

# `value` implicitly calls `join`, so the explicit `join` calls above are
# not strictly necessary.
result1 = fiber1.value
result2 = fiber2.value
```

The new methods added by Psyllium make it easy to retrieve the final value from
a block given to a Fiber. This is the exact same pattern that is used often with
Threads.

This doesn't solve all problems. A poorly implemented Fiber Scheduler can
_potentially_ cause issues, whereas Thread scheduling is "fair" in that all
Threads should receive an equal amount of CPU time. Auto-scheduled Fibers will
only relinquish control when they hit a blocking operation (blocking IO, sleep,
and so on); if a Fiber never hits a blocking operation, it will just keep
running until the Fiber finishes, which may never happen, depending on what the
block given to the Fiber does. Even then it is dependent on the Fiber scheduler
to ensure no Fibers become "starved" and wait forever before they get a chance
to run again.

Even with these caveats, Fibers, especially Psyllium enhanced ones, are worth
exploring if you have a use case that is heavily IO bound as opposed to CPU
bound. With some care, you can vastly increase your throughput while managing
to keep memory usage down, just by switching from Threads to Psyllium enhanced
Fibers, and (if your use case is a web server) using a Fiber based web server
like Falcon.
