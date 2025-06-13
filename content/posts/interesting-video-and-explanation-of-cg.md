---
title: Interesting video and an explanation of CG animation
date: '2010-09-02T06:27:00-06:00'
Author: Ethan Estrada
aliases: [/2010/09/interesting-video-and-explanation-of-cg.html]
tags: ['CGI', 'Blogspot']
draft: false
---

<!-- TODO: copy images from blogspot into this repo and link to them in this post. -->

Hi y'all.
I found this video (UPDATE: previously linked video was an old flash player embed
and no longer exists)
and it got me to thinking about special effects and how we perceive them.
Even though everyone in the studio audience had undoubtedly seen blockbuster films with eye fooling special effects,
they went wild for this performance of a rather simple concept.
Don't misunderstand me;
what they are doing is extremely difficult.
However,
something is often more impressive to us when we can understand the effort put into it.

On that note of effort and understanding,
the topic of my career goals
and current use of time in school often comes up
in conversations these days (part of being a college student I suppose).
When I mention that I am studying animation and working on BYU animated student films,
peoples' eyes immediately light up;
even if the person in question doesn't know
the great track record of BYU's animation department,
they at least like animation (who hasn't seen Toy Story and loved it?).
They then try to ask about (and grasp) what it is I do in the whole film-making process.
Once I begin dropping technical (and sometimes not so technical) terms
and concepts about what it is that I contribute to the overall process,
the sparkle in most people's eyes fades
and is quickly replaced by a look of utter confusion.
The reality is that most people do not fully understand
what exactly is involved in the process of computer animation in general
and in making a collaborative film in specific.

For instance,
a full length feature film from Pixar takes about 5 years to make,
from absolute start to finish,
with a crew of about 400 people working full time and often overtime.
The reason that Pixar can release a film every year or two is because
they have multiple films being produced at the same time,
all of them at varying points in the production process.
They also employ much more than 400 people.

With a BYU short animated film of about a 5 minute length,
it takes about 1-2 years with 20-30 students working part-time on the process.
For the sake of understanding why this process often takes so long,
I will try to explain in the simplest terms possible
what computer animation is and isn't.

Before we begin,
let's address the term "Computer Animation."
Shortly after the release of some of the earliest computer generated animated films
(Toy Story being a great example),
my father would be asked what he did for a profession.
When he replied "animation" people would often retort "Well isn't that all done by computers now?"
He would then reply "Well someone is sitting behind those computers."
Sometimes the phrase "Computer Animation" misleads people into the thinking
that somehow computers do all the work.
In reality it ought to be called "computer assisted animation",
because,
in the end,
the computer is simply a tool.
To paraphrase one of my professors
"If you produced garbage art work to begin with,
all the computer will do is chrome plate it."
The responsibility of a quality product rests on the shoulders of the artist,
not the tools he/she uses.

Now let's begin talking about the basics of how computer animation is done
(in most cases).
I will keep this as simple as possible
to make it accessible to anyone who may read this post.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjh_T4du5gDy9zWrSzpMZ092OOrsMucOoISJypbmnR4J4E3Z3ECHznTCQuhwPwHhT_VCTDr5L1HcBFNaCKLEUPt18iLDQsimL-Bw54Z7L6bAixNcXailfrGZmZY5klek74Z0TM2VC2mlLI/s400/Anim_geometry.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjh_T4du5gDy9zWrSzpMZ092OOrsMucOoISJypbmnR4J4E3Z3ECHznTCQuhwPwHhT_VCTDr5L1HcBFNaCKLEUPt18iLDQsimL-Bw54Z7L6bAixNcXailfrGZmZY5klek74Z0TM2VC2mlLI/s1600/Anim_geometry.png)

Basically the easiest way to think about how an animated film is made
is that the artists of a film are creating a virtual set
with virtual characters inside the computer.
The first step of this process is modelling.
No,
the creators don't strut down the catwalk in their best clothing.
I mean modelling as in sculpting.
Artist who are, appropriately enough,
called modellers create the objects in virtual "space" with 3 dimensions (height,
width and depth).
Look at the picture of the sphere to get an idea of this (just FYI,
you will need to click on the images in this blog post
to see them at their full resolution and understand the things I am talking about).

You might notice that our "sphere" is rather jagged.
Because the computer has to figure out where each face,
edge and vertex is in space,
manipulating the object is more easily done with less detail
since the computer can run faster.
Later in the process the geometry can be smoothed and have more detail added
once we no longer need to actively change the geometry.

Anyway,
back to the point.
Now that I have this sphere
I can manipulate it by squashing and stretching it in varying ways
until I have the desired shape.
Let's look at the shape below.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhv1W5x4UHfKXTGYHbG_xHwvyej4x4yeGlA49_3wjBl708LgwJmJ-FsHqRO1PE_Zvi-EC18spb-fs2WPlKUTzUkEmG-QCZsxB1wntNYYWwaVOUpFpfb4GXR0OaOQ8x1yQYi3J5q6XxhoFY/s400/Anim_apple.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhv1W5x4UHfKXTGYHbG_xHwvyej4x4yeGlA49_3wjBl708LgwJmJ-FsHqRO1PE_Zvi-EC18spb-fs2WPlKUTzUkEmG-QCZsxB1wntNYYWwaVOUpFpfb4GXR0OaOQ8x1yQYi3J5q6XxhoFY/s1600/Anim_apple.png)

You now see that we have something that resembles (at least somewhat) an apple.
Hurray.
But it is all grey and ugly.
Why,
you might ask?
This is answered by (ta-da) texturing!

Texturing is basically the process in which a boring grey object such as our apple
is told how to react to light.
For instance,
why can you perceive that a person is wearing clothes
on a certain part of their body and not on a another?
You might say the color difference between the skin and the clothing,
the difference in how shiny a person's skin is compared to a cotton shirt
or you might simply say "This question is dumb."
All of these are correct!
The question is dumb
because we already intuitively know how certain things should react to light.
We would be frightened if some one's skin looked shiny like metal
(see image below from Terminator 2)
and we would find it odd if grass was colored purple.
Texturing of geometry
is part of what makes films with computer generated footage
either believable or laughable.

[![](https://lh3.googleusercontent.com/blogger_img_proxy/AEn0k_v3GVJR2kNEIS_4N5zHxc2GaZkh2mFT8bEhqtvSe-ztP3acPLDaFW-9FBW2L7Y-glbXhs9Rd98Rz-T2CsYHbe_X0_3WfTUy8ihR2cebmZKHq79KMq2NxWcqXD-iSDPQUeKw4hm-MtBO15BBT7VH=s0-d)](http://www.soundonsight.org/wp-content/uploads/2009/05/4-liquid-metal_l.jpg)

Texturing is often done by wrapping the shape with a flat plane of an image file,
much like how a map is wrapped around a sphere to make a globe of the earth.
Sometimes textures are hand painted
and sometimes we have the computer calculate
and generate random patterns that we can assign colors
and other attributes to.
Often both methods together are needed to create believable
and life like textures.
For this example we will keep things simple both for your sake
and mine (as I don't really have the time to hand paint an apple texture).
We will tell the computer to assign the apple a simple red color.
We will then tell the computer to lay over the top of that a layer
that makes the apple look dotted with pores when it reacts to light
(this is called a [bump map. Click the link to wikipedia](http://en.wikipedia.org/wiki/Bump_mapping) for more info).

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj8tLhBeRwdK5D1GnqStQOguGO-CUvX4Y7u8EV9oF5UEPvizGr0D4qELLBeGl_QIDry9r1hF_uuBc2EP0yfqtIkuQAKgjGRVrmJbDXXq1xXg07NMo_WW1oXE0GJZzTvomH-V9qFHMyh-7Q/s400/Anim_textured.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj8tLhBeRwdK5D1GnqStQOguGO-CUvX4Y7u8EV9oF5UEPvizGr0D4qELLBeGl_QIDry9r1hF_uuBc2EP0yfqtIkuQAKgjGRVrmJbDXXq1xXg07NMo_WW1oXE0GJZzTvomH-V9qFHMyh-7Q/s1600/Anim_textured.png)

Alright.
But the apple looks a little bit cheap.
This is because this is merely a preview of what the final image will look like.
What we need to do now is render the image.
Rendering is when a virtual set is sent to a program called a,
you guessed it,
renderer.
The renderer takes all the data about the object that we have created,
processes it,
and then dumps out an image for us to look at.
Let's do that now and see what we end up with.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjcKr_7aZ4scg15QP-b6dKQ1AJO91nlcfIJQX-9zido9lIjDxhUCRZqX0OUgKE7OC3T4TjXk2I8tMBtTGNXs9BpUa_R4uKCWh-F1cVkNM_1d0poLRku_nklmkYdzdfXOWVYl1kPo7Liyts/s400/Anim_render.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjcKr_7aZ4scg15QP-b6dKQ1AJO91nlcfIJQX-9zido9lIjDxhUCRZqX0OUgKE7OC3T4TjXk2I8tMBtTGNXs9BpUa_R4uKCWh-F1cVkNM_1d0poLRku_nklmkYdzdfXOWVYl1kPo7Liyts/s1600/Anim_render.png)

Yuck!
Sadly,
often this is how many aspects of animation are done: render,
rinse,
and repeat until the desired look is achieved.
Now I will play with some settings and try to get a better image to pump out.

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhY4G3ink7BNtp5BSULZ55etrz5WxqPWdH-zk7ntugd7TPNkfZwvNis9yhlfjqJrA4nZDCw3Os9s8qLyL_iENhtcYzBNCHL7XqwpAAE2clq2KXC3QUrWw5nwBD5fxc4oTL_oTJ2p5mPZhI/s400/Anim_render_2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhY4G3ink7BNtp5BSULZ55etrz5WxqPWdH-zk7ntugd7TPNkfZwvNis9yhlfjqJrA4nZDCw3Os9s8qLyL_iENhtcYzBNCHL7XqwpAAE2clq2KXC3QUrWw5nwBD5fxc4oTL_oTJ2p5mPZhI/s1600/Anim_render_2.png)

Alright.
While this is by no means perfect,
it is much better than what we had before.
Something you may have noticed is that the default lighting that this program sets up is very boring.
Well,
luckily with computer animation we have control of lights as well.
And even better than that,
inside a computer we can break the laws of physics!
Light sources don't have to be visible,
lights don't need to cast shadows if we don't want them to
and lights can be set to affect certain objects and not others.
Pretty nifty huh?
Lets look at a simple lighting set up,
often called a 3 point light set up.
We will have our main (or "key") light about 45 degrees counter clockwise
and 45 degrees vertical to our object.
We will then set our fill light (meant to brighten the shadow side of the object) 45 degrees clockwise
and 45 degrees vertically.
Then we will set a rim light behind our object to help us better see the outline
and shape of the object.
This lighting set up is used in both animation and live action film frequently.
Here is the complete set up with all the lights:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgxgSOYLl2GvjWX6gRM_8d867s5jFJoBkEAN6-fMigEjC1oY-LgOfolKBITGWznuirIq0-CE44MvIwLY1HnReXMZBbLdG5S6tS73GpFI3hay9vWkbRBVKfGf1FfP9mTpoVWAhjdUcyrCGE/s400/Anim_lighting.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgxgSOYLl2GvjWX6gRM_8d867s5jFJoBkEAN6-fMigEjC1oY-LgOfolKBITGWznuirIq0-CE44MvIwLY1HnReXMZBbLdG5S6tS73GpFI3hay9vWkbRBVKfGf1FfP9mTpoVWAhjdUcyrCGE/s1600/Anim_lighting.png)

There.
Now our apple looks far more interesting with just nd thus definea simple background
and some basic lighting.
For the sake of learning let's compare the shot with some of the lights turned off.

First,
lets look at the same shot without our rim light:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_THwt1x3ZrcMbjQM4QxyylUmZTeTdNHt53Dywxh2EZpqaHlo2YiBSre6NL6fdp1-leSrTUEv0CnusX0YQaEPZLdoxrtf6RrKERI5QU7yYCAegAHeUpkoyVEEwXlGXRm0sBLp-uAhljXw/s400/Anim_lighting_2.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEj_THwt1x3ZrcMbjQM4QxyylUmZTeTdNHt53Dywxh2EZpqaHlo2YiBSre6NL6fdp1-leSrTUEv0CnusX0YQaEPZLdoxrtf6RrKERI5QU7yYCAegAHeUpkoyVEEwXlGXRm0sBLp-uAhljXw/s1600/Anim_lighting_2.png)

Now without the fill or rim lights:

[![](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEirXp9TNoGjvI6i049aWJnesMy4XhYEr_2egUBjjYMstmj_CNTbwtBRtCfoOdrCXbw6MJpeaxjjXnVDNy6SroJ51F2_9dwBX1ZjGb1btibZ6YQcp5iDOsUvW2EkjTDEEkp1F7dYt8T7Yrk/s400/Anim_lighting_3.png)](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEirXp9TNoGjvI6i049aWJnesMy4XhYEr_2egUBjjYMstmj_CNTbwtBRtCfoOdrCXbw6MJpeaxjjXnVDNy6SroJ51F2_9dwBX1ZjGb1btibZ6YQcp5iDOsUvW2EkjTDEEkp1F7dYt8T7Yrk/s1600/Anim_lighting_3.png)

The differences are minor but they all add up to make the shot look good (or at least better than before).
Keep in mind that certain colors of light play off of each other in different ways.
For instance,
the rim and fill lights are orange and pink,
respectively.
But a person would often never guess this just by looking at the completed image
as the blue from our key light is the over powering force in his image.

Ultimately,
in a large production,
there are people who actually do the animating (as in movement)
and others who make sure that the people who need certain files
can get them when they need them,
but I won't go into all that here in this particular posting.
Hopefully at the end of this you know a bit more about movie magic
than you did coming into the article.
And more importantly,
I hope you enjoyed  the process of learning about all of this.
Good luck all and I'll be back again soon.
