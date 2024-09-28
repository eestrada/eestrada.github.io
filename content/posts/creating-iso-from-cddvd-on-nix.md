---
title: Creating an ISO image from a CD/DVD on Unix
date: '2013-01-03T12:48:00-07:00'
Author: Ethan Estrada
aliases: [/2013/01/creating-iso-from-cddvd-on-nix.html]
tags: [Unix, Blogspot]
draft: false
---

Hey, it has been a while since I last posted anything.
I apologize to some of you since this post is going to be rather techie/geekie.
It is more as a reminder to myself about how to do this than anything else.

Earlier today, I was furiously trying to find a utility on [Linux](http://en.wikipedia.org/wiki/Linux)
to take a CD/DVD
and create an [ISO image](http://en.wikipedia.org/wiki/Iso_image) from it.
I was coming up dry and was feeling a bit frustrated
until I stumbled onto [this website](http://www.tech-recipes.com/rx/2769/ubuntu_how_to_create_iso_image_from_cd_dvd/).
Once I read it I felt like a complete moron.
Why did I feel so stupid?
One of the great things about [Linux](http://en.wikipedia.org/wiki/Linux),
[BSD](http://en.wikipedia.org/wiki/BSD),
[Mac OS X](http://en.wikipedia.org/wiki/Mac_OS_X)
and pretty much every other [OS](http://en.wikipedia.org/wiki/Operating_system)
descended from [Unix](http://en.wikipedia.org/wiki/Unix-like)
is that [everything is a file](https://en.wikipedia.org/wiki/Everything_is_a_file).
Literally everything.
And I had forgotten
that disc drives (including [optical drives](http://en.wikipedia.org/wiki/Optical_drive))
fall well within the category of "everything".

Thus the way to create an ISO image from a CD/DVD
is as simple as running the following from the [terminal](http://en.wikipedia.org/wiki/Terminal_emulator):

```sh
cat /dev/cdrom > /home/user/path/to/image.iso
```

That's it.
Simply [redirect](<http://en.wikipedia.org/wiki/Redirection_(computing)>)
the output of CD/DVD device into a file.
Easy, right?
