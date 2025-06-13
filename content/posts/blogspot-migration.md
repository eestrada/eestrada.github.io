---
title: Blogspot Migration
date: '2024-10-09T22:37:00-05:00'
Author: Ethan Estrada
aliases: []
tags: ['blog']
draft: false
---

After many years, I have (finally) ported my posts
from Blogspot to my static blog.
Part of what took so many years was:

1. I assumed I needed to do something fancy to port them over.
2. My previous static blog engine ([Frog](https://github.com/greghendershott/frog))
   had a limited feature set,
   which meant that redirects of paths and whatnot
   was an exercise left to the user (i.e. me)
   and I never felt it justified the time investment to get create a workaround.

The answers to these two hold ups are:

1. I just pushed the rendered HTML from Blogspot
   through an HTML to Markdown converter,
   one post at a time, by hand.
   It was relatively painless.
   I also ported over the comments this way;
   this means they are no longer dynamic,
   but considering no one has commented on that blog in a decade,
   it isn't a big deal.
2. I have since moved over to using a more featureful generator ([Hugo](https://gohugo.io/))
   instead of Frog.
   It supports things like aliases
   that have made the transition from Blogspot more seamless.

I haven't yet copied the still images over from the old hosting providers.
I would prefer to host those within the static site as well.
It is impossible to know
when a hosting provider will suddenly decide to stop hosting.

For example, some of the old full resolution images were hosted on PicasaWeb
(remember that old thing?).
In typical Google fashion,
this product was killed years ago.
They gave a grace period of a few years to retrieve the photos,
but that grace period has long since ended.
Now those full rez images are lost to the sands of time.

I can avoid this sort of pain by hosting the images myself.
If the people behind Github or S3 or whatever I'm using at the moment
decide to stop hosting my static files,
I can just push my files saved in my git repo somewhere else.
Nothing is lost.

As it stands right now, I could redirect traffic from Blogspot,
and the paths to all the old posts should redirect correctly
because of the aliases used in Hugo.
I will probably hold off on flipping the switch on this
until at least the comments are moved over.

There are only a few posts with Comments and images,
so it shouldn't take long once I choose to do it.
I just need to choose to do it :) .

In the transition to Hugo,
the ability to add new comments is going away.
On Blogspot/Blogger, my blog used the builtin commenting system.
On my Frog site, my blog used Disqus.
Here there is nothing.

Why no commenting system?
On Blogspot, as my posting frequency became infrequent and sporadic,
the comments also began to become less and less.
On my Frog/Disqus based site,
I never had a single comment.
I can't blame people for disengaging:
I was posting on average once per year
and half of those post are apologies about not posting more often.

Why have a comment system if it isn't used?
I'll just yell my thoughts into the void
without a feedback mechanism.
If someone has something to say they can contact me
through any of my social handles I am linking on the site.

I'm also not using Google Analytics anymore.
I'm not totally ruling out the possibility of using an analytics engine in the future,
but for now I don't care enough to track traffic.
I just want a place to post my thoughts.

Writing and posting regularly and improving the quality of my writing
are all things
that are vastly more important than a comments system or an analytics engine.
Thus, I'm going to focus on those for the time being.
