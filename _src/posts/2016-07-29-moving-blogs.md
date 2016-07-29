    Title: Moving blogs
    Date: 2016-07-29T14:52:18
    Tags: blog
    Authors: Ethan Estrada

I am moving blogging platforms and thought I should maybe explain why.

<!-- more -->

In the past I have been hosting my blog on Google's Blogger platform.
This has served me pretty well over the years along with the limited
number of posts I have made. However, as I have tried to expand the
blog into more of a general website, it has been an uphill battle
fighting against the workflow of the blogging system itself. I don't
forsee wordpress being much different.

Besides, one of my reasons for moving to my current setup was
simplicity and control. I am using a static site generator now (ala
Jekyll). The reasons for this being that:

1. I now directly control my own content
2. I don't need to set up a wordpress server or anything of the sort
3. There should never be downtime since the site is statically hosted
   on Github or S3 or whereever
4. Inline with number 1, I can version control my content (with
   something simple like git)
5. I can write my posts in MarkDown
6. I can embed source code styling instead of reasching out to
   JavaScript libraries to do it dynamically at run time

I like all these reasons. It also means I can theme the site however I
like using simple HTML templates. I can also add whatever types of
pages I want since in the end it is just static HTML.

Really, there are lots of reasons to use a static site generator. I am
currently using [frog], the **fr**zen bl**og** generator, written in a
somewhat lesser known language called Racket (a dialect of Lisp
descended from Scheme). I like the language I want to support its
increased usage and the best way to do that is to use projects that
use it.

I plan to port over my old blog posts once I get a chance, although that may prove to be a bit of a chore.
I'll probably end up avoiding it for a super long time.

[frog]: https://github.com/greghendershott/frog
