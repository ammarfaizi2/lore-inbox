Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTLJNDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLJNDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:03:39 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:23051
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262655AbTLJNDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:03:36 -0500
Date: Wed, 10 Dec 2003 04:57:56 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312041743530.6638@home.osdl.org>
Message-ID: <Pine.LNX.4.10.10312100419220.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

So basically anyone in the past-present-future who worked on-with-about
the linux kernel is now tainted forever.  Get real Linus, that would mean
everyone would have to segment their brain and it will not happen.

The statement that something load means you have applied standard fair use
of the api's described in the manual.  Since you refuse to set a standard
document to become the manual, the source code itself is the manual.

Like it or not, your position to force people to read the source code or
read "Linux Kernel Internals", "Linux Device Drivers 1 & 2", and/or any
other web content from the internet make the kernel a periodical
reference.  Now that it is a reference, the ideas can be extracted and
used however and where ever.  The simple fact there are books with ISBN
which are verbatium printout of the kernel source for a given snap shot in
time, well the ideas are freed and the actual document is an empty shell!

Thus case law supports fair use and defines the unprotectable API.
Since the headers are the effective API, the are not copyright protected.
They can not, do not, and never will be a means test for "derivative
works".  Clear lines of derivatives if the headers are such, then
everything running in the in user space is a derivative.

Kernel headers provide the mappings to the compilers and libraries.
The libraries and headers in user space will dirty any applications.
Simple proof, rm -rf /usr/include/linux and /usr/include/asm.
Try to build any application and it will bomb in most cases.

So if modules are derived works then so is all of user space.
Then again, the linux kernel is an integration of ideas and no longer
could stand on its own with out all the contributions.

Linux == the sum of the drivers ?
The drivers are derivatives of Linux ?

Copyright License is such a JOKE, I really wish you would do a Michael
Jackson (the white glove grab) and find a way to switch by force to a
better license model.

OSL 1 and 2 are a preferred choice as they are slowly creaping into the
kernel.  The beauty and pain of OSL is that SCO would be a NOOP.  The
requirement imposed on the contributing author to indemnify (sp really
bad) the changes/patches to the codebase core, makes it a better world.
In short code sets of questionable origin are the liabities of the author
and not the community.

I know, everyone is going to flame me, Dave Miller is going to kick me off
lkml and whippity flip.  The majority of the meatballs here do not have
Lawyers nor could they afford them.  So it comes down to those who have
and those who do not.  The haves will anyway crush those who don't.

Well this should be enough bait to get it going.  It is chilly here in
California tonight and a little warmth from electrons heat would be good.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

PS sorry for the fragmented thoughts it is late.

On Thu, 4 Dec 2003, Linus Torvalds wrote:

> 
> 
> On Thu, 4 Dec 2003, Paul Adams wrote:
> >
> > A work that is inspired by Linux is no more a derivative work than
> > a programmatic musical composition inspired by a novel.  Having
> > Linux in mind cannot be enough to constitute infringement.
> 
> But it does - you have to include the Linux header files in order to be
> able to make any nontrivial module.
> 
> I'm not claiming that "thinking about Linux makes you tainted". It's not
> about inspiration. But it's a bit like getting somebody pregnant: you have
> to do a lot more than just think about it to actually make it happen, or
> every high school in the world would be crawling with babies.
> 
> In other words: feel free to be inspired by Linux all you want. But if you
> release a binary module that loads and works, you've been doing more than
> just feeling inspired. And then you need to be _careful_.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

