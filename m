Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284415AbRLRSIl>; Tue, 18 Dec 2001 13:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284421AbRLRSIV>; Tue, 18 Dec 2001 13:08:21 -0500
Received: from otter.mbay.net ([206.40.79.2]:61711 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S284415AbRLRSIS>;
	Tue, 18 Dec 2001 13:08:18 -0500
Date: Tue, 18 Dec 2001 10:08:00 -0800 (PST)
From: John Alvord <jalvo@mbay.net>
To: Dana Lacoste <dana.lacoste@peregrine.com>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: The direction linux is taking
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A07@ottonexc1.ottawa.loran.com>
Message-ID: <Pine.LNX.4.20.0112181005290.12820-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Dana Lacoste wrote:

> > > > 1. Are we satisfied with the source code control system ?
> 
> > > Yes.  Alan (2.2) and Marcelo (2.4) and Linus (2.5) are doing
> > > a good job with source control.
> 
> > Not really. We do a passable job. Stuff gets dropped, lost, 
> > deferred and forgotten, applied when it conflicts with other work
> > - much of this stuff that software wouldnt actually improve on over a 
> > person
> 
> So the same result then :
> We are 'satisfied with the current source code control system'
> because there isn't a way currently available that would allow
> for any significant benefit.
> 
> > > Although this seems annoying, it's just one facet of the
> > > primary difference between Linux and a commercially based
> > > kernel : if you want to know how something works and how
> > > it's being developed, then you MUST participate, in this
> > > and other mailing lists.
> 
> > That wont help you - most discussion occurs in private because l/k 
> > is too noisy and many key people dont read it.
> 
> ...but if you are working with the code and you see something change
> the mailing list is the place to ask, correct?
> 
> What I'm saying isn't so much that the mailing lists are complete,
> but that you have to keep current with the community if you want to
> keep current with its work.
> 
> > > There is no central product, so there can be no central bug track.
> > > (see below)
> 
> > Rubbish. Ask the engineering world about fault tracking. You won't get
> > "different products no central flaw tracking" you'll get 
> > extensive cross
> > correlation, statistical tools and the like in any syste, 
> > where reliability
> > matters
> 
> > Many kernel bug reports end up invisible to some of the developers.
> 
> Many kernel developers don't read LKML.
> Isn't that their flaw?
> 
> Many bug reports don't end up in the right place.
> (i.e. a Sparc patch on the LKML but not the Sparc-Linux mailing lists)
> 
> How is a central bug repository going to help?
> 
> For example. Red Hat's knowledge base is a piece of crap.  It's
> impossible to find anything because of the millions of variations
> on different products.
> 
> You can't maintain a central bug repository for separate product
> streams (Red Hat's kernel vs. "Stock" vs. Suse vs. VA, etc)
> because there's too many variables.  If you want a centralized
> bug tracking system then you MUST use the same product or it
> will end up tracking end-user bugs instead of developer bugs
> because the developers won't use it.
> 
> I sincerely challenge you to propose a method for centralizing
> bug tracking in the Linux kernel that _can_ be used by the
> community as a whole.  That means something that Linus would use
> _and_ somebody who doesn't subscribe to LKML can use to find out
> why he can't compile loop.o on his redhat 7.0 system with the
> kernel he got from kernel.org a few weeks ago.

A little while ago, Linus argued (apparently) seriously that chaotic
development gave a better result that more tightly controlled
methods... That a larger space of solutions was searched and better
optimums were found.

Maybe the current development environment is planned chaos.

john alvord

