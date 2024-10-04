---
title: Blogspot Migration
date: '2024-10-01T22:32:34-05:00'
Author: Ethan Estrada
aliases: []
tags: [blog]
draft: true
---

After many years, I have (finally) ported my posts
from Blogspot to my static blog.
Part of what took so many years was:

1. I assumed I needed to do something fancy to port them over.
2. My previous static blog engine ([Frog](https://github.com/greghendershott/frog))
   had a limited featureset,
   which caused some questions around redirects of paths and whatnot.

The answers to these two hold ups are:

1. I just pushed the HTML from Blogspot through an HTML to Markdown converter,
   one post at a time, by hand.
   It was relatively painless.
   The comments won't transfer over this way
   unless I just copy them as raw HTML to Markdown conversion as well.
   Maybe I'll do that just so that I don't lose them.
   I don't know; I'm still thinking it over.
2. I have since moved over to using a more featureful generator ([Hugo](https://gohugo.io/))
   instead of Frog.
   It supports things like aliases
   that have made the transition from Blogspot more seamless.

I haven't yet copied the still images over from the old hosting providers.
I would prefer to host those within the static site as well.
It isn't clear when a hosting provider will suddenly decide to stop hosting.

For example, some of the old full resolution images were hosted on PicasaWeb
(remember that old thing?).
In typical Google fashion,
this product was killed years ago.
Now those full rez images are lost to the sands of time.

I can avoid this sort of pain by hosting the images myself.
If the people behind Github or S3 or whatever decide to stop hosting my static files,
I can just push my files saved in my git repo somewhere else.
Nothing is lost.

As it stands right now, I could redirect traffic from Blogspot,
and the paths to all the old post should redirect correctly
because of the aliases used in Hugo.
I will probably hold off on flipping the switch on this
until the comments and images are moved over.

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
I'm sure if someone has something to say,
they will find a way to contact me.
I'll post my Twitter handle (I'm still not calling it X) somewhere on this site,
probably;
folks can reach out to me that way.
