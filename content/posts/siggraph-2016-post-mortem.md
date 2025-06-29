---
title: SIGGRAPH 2016 Post Mortem
date: '2016-07-29T14:52:18-07:00'
author: Ethan Estrada
aliases: [/blog/2016/07/29/siggraph-2016-post-mortem.html]
tags: ['SIGGRAPH', 'CGI', 'MetaPipe']
draft: false
---

I had the opportunity to attend SIGGRAPH this year as a representative
of [MetaPipe](http://metapipe.com). For as fun as it was to meet with
representatives of various software and cloud companies, I am happy to
be able to get my nose back to the grindstone on MetaPipe. I'm
extremely excited about the tech we are working on for the service and
I can't wait to get it to the point where we can start demoing it
publicly to get everyone's feedback. We started a lot of converstaions
at SIGGRAPH with various companies that we feel fairly confident will
turn into more concrete agreements in the near future.

<!-- more -->

I got an "Exhibits Only" pass during the convention; we are trying to
be as scrappy, lean, and frugal as we can be so splurging on something
like a "Full Conference" pass would definitly be overkill especially
when Avere provided us with a code for a free "Exhibits Only"
pass. Besides, all of the people we wanted to talk to were on the
exhibit floor anyway. Maybe in future years we will get more complete
passes to check out presentations to see the state of the industry,
but for now we are keeping it simple. Ideally we will be able to
justify having our own booth next year!

Even though I've heard SIGGRAPH has shrunk in attendence some in
recent years, it is still very impressive in size and scope. I think
this in part is from the decreased focus on the job fair and a greater
focus on interconnect between vendors. SIGGRAPH seems less useful for
individual artists looking for work than it used to be.

The biggest focus at the convention seemed to be VR and AR. Pretty
much every booth from software vendors featured VR workflows. The new
VR camera from Houdini, CaraVR addon for Nuke from The Foundry, the
(not yet publicly available) VR toolset for Mocha from Imagineer
systems, and more from other companies as well.

Not surprisingly, cloud was also a big focus (which was a big
attraction to us). Many softwares packages such as deadline from
Thinkbox software and Tractor from Pixar are starting to have more and
more cloud based features, such as extremely granular billing for
various software packages (from Thinkbox) and intelligent autoscaling
features (from Tractor, and if I remember correctly, Thinkbox was
working on similar stuff as well).

Autoscaling is an interesting problem in and of itself; scale too
quickly and users will rack up charges for compute they didn't really
use efficiently.  Scale too slowly and what should only take a few
minutes could end up taking hours. Some workloads are heavy per frame
and some are light. When do you scale up? How automagical can you make
it for the user so that they have fewer knobs to deal with? Can you
base it off of the basic priority parameter that most render
schedulers already have, or do you need a different mechanism for it?
Perhaps something like the expected average render time per frame (or
task)? What about distributed simulations that are parallel, but need
to be in lockstep? They should probably all spin up at the same time,
but how do you signal this to the scheduler in a relatively turnkey
way?

During the convention, I either asked these questions to the various
developers on the farm manager teams, or thought of them after the
fact due to mulling over the questions I had asked or information
I had learned. It isn't an easy problem to solve and one that I am sure
will have many more years of time and effort poured into it before
well rounded solutions come to market.
