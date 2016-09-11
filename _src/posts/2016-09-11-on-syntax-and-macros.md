    Title: On Syntax and Macros
    Date: 2016-09-10T23:11:20
    Tags: Lisp, CGI
    Authors: Ethan Estrada

From what I have read, it seems that most people have an ultimate Zen
moment with Lisp that makes the universe seem to fall into order (or,
[so says Eric S. Raymond](http://www.catb.org/~esr/faqs/hacker-howto.html#skills1)). My
journey with Lisp so far hasn't been like that. Instead, it has been a
number of smaller "Aha!" moments. In fact, I just had one today. Maybe
my big Zen moment will come later. I guess I'll just need to keep
learning and see where the Lisp journey takes me.

<!-- more -->

Getting back to the "Aha!" moment, I was reading
[an article by Andrew Gavin about how he used Lisp in creating games for Naughty Dog](http://all-things-andy-gavin.com/2011/03/12/making-crash-bandicoot-gool-part-9/). In
the article he says that "...C provides series of convenient macros
for flow control, arithmetic operations, memory reference, function
calling, and structure access."  My first reaction was "No,
Andy. You've got it all wrong. Those aren't macros, they are part of
the syntax..."

> Syntax, in any language, is just a bunch of macros you didn't need
> to write.

Then I paused, thought for a minute, and made a realization: if macros
are syntax, is the inverse also true? Is syntax just macros? Yes, yes
it is.  Syntax, in any language, is just a bunch of macros you didn't
need to write. Why? Because all languages are later compiled to
something else.

Compilation is a fancy way of saying you transform one language into
another, much like macros transform one piece of syntax into another
piece of syntax. Not _much_ like; it's **_exactly_** like
that. Transforming Lisp to Lisp is not all that different from
transforming C to assembly, or Python to bytecode.  That is what
Andrew ultimately does with his custom Lisp dialect, GOOL: compile
Lisp into R3000 assembly code.

So, thanks Andy. Your twenty year old article taught me something
fundemental about Lisp and computer science. And the Lisp journey
continues.
