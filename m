Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282067AbRLRPTZ>; Tue, 18 Dec 2001 10:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282482AbRLRPTS>; Tue, 18 Dec 2001 10:19:18 -0500
Received: from [198.17.35.35] ([198.17.35.35]:16627 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S281835AbRLRPS6>;
	Tue, 18 Dec 2001 10:18:58 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2A07@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: The direction linux is taking
Date: Tue, 18 Dec 2001 07:18:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 1. Are we satisfied with the source code control system ?

> > Yes.  Alan (2.2) and Marcelo (2.4) and Linus (2.5) are doing
> > a good job with source control.

> Not really. We do a passable job. Stuff gets dropped, lost, 
> deferred and forgotten, applied when it conflicts with other work
> - much of this stuff that software wouldnt actually improve on over a 
> person

So the same result then :
We are 'satisfied with the current source code control system'
because there isn't a way currently available that would allow
for any significant benefit.

> > Although this seems annoying, it's just one facet of the
> > primary difference between Linux and a commercially based
> > kernel : if you want to know how something works and how
> > it's being developed, then you MUST participate, in this
> > and other mailing lists.

> That wont help you - most discussion occurs in private because l/k 
> is too noisy and many key people dont read it.

...but if you are working with the code and you see something change
the mailing list is the place to ask, correct?

What I'm saying isn't so much that the mailing lists are complete,
but that you have to keep current with the community if you want to
keep current with its work.

> > There is no central product, so there can be no central bug track.
> > (see below)

> Rubbish. Ask the engineering world about fault tracking. You won't get
> "different products no central flaw tracking" you'll get 
> extensive cross
> correlation, statistical tools and the like in any syste, 
> where reliability
> matters

> Many kernel bug reports end up invisible to some of the developers.

Many kernel developers don't read LKML.
Isn't that their flaw?

Many bug reports don't end up in the right place.
(i.e. a Sparc patch on the LKML but not the Sparc-Linux mailing lists)

How is a central bug repository going to help?

For example. Red Hat's knowledge base is a piece of crap.  It's
impossible to find anything because of the millions of variations
on different products.

You can't maintain a central bug repository for separate product
streams (Red Hat's kernel vs. "Stock" vs. Suse vs. VA, etc)
because there's too many variables.  If you want a centralized
bug tracking system then you MUST use the same product or it
will end up tracking end-user bugs instead of developer bugs
because the developers won't use it.

I sincerely challenge you to propose a method for centralizing
bug tracking in the Linux kernel that _can_ be used by the
community as a whole.  That means something that Linus would use
_and_ somebody who doesn't subscribe to LKML can use to find out
why he can't compile loop.o on his redhat 7.0 system with the
kernel he got from kernel.org a few weeks ago.

Dana Lacoste
Linux Developer
Ottawa, Canada
