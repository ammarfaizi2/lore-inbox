Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290009AbSA3QhK>; Wed, 30 Jan 2002 11:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290033AbSA3Qfo>; Wed, 30 Jan 2002 11:35:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16139
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S290018AbSA3Qer>; Wed, 30 Jan 2002 11:34:47 -0500
Date: Wed, 30 Jan 2002 08:26:52 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rob Landley <landley@trommello.org>, Skip Ford <skip.ford@verizon.net>,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10201300752320.16249-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Linus Torvalds wrote:

> 
> On Tue, 29 Jan 2002, Rob Landley wrote:
> > > >
> > > > Then why not give the subsystem maintainers patch permissions on your
> > > > tree. Sort of like committers.  The problem people have is that you're
> > > > dropping patches from those ten-twenty people you trust.
> > >
> > > No. Ask them, and they will (I bet) pretty uniformly tell you that I'm
> > > _not_ dropping their patches (although I'm sometimes critical of them,
> > > and will tell them that they do not get applied).
> >
> > Andre Hedrick, Eric Raymond, Rik van Riel, Michael Elizabeth Chastain, Axel
> > Boldt...
> 
> NONE of those are in the ten-twenty people group.

Well it is nice to know the facts now.  How about having just a little
more courage and publish your offical tree of who is "IN" and "OUT" so
folks can decide for themselves.  It is an honor to be in the lesser class
of folks who care more but less is accepted.

As for clean coding, you have to make a mess to in one part of a room by
pushing the contents to a corner and weeding out the useful.  Since you
have always stated public/private/in-person the sensitve nature of the
changes to the low-level storage drivers, those who have tried to promote
regression testing of layers and isolation points, have been ignored,
laughed, scorned, etc ...

Regardless if many people see the need and other are tired of being the
garbage collector of blame, when valid and proper solutions have been
presented in the past, specifically "FILE SYSTEM CORRUPTION".

Only after a few cases of pointing out flaws and failures in darwinisms
development, few became ignored.  Noting the total freedom you take to
blanket blame folks for issues which they are not responsible for
creating, an easy target allows one to ignore ultimate responsiblity.

> How many people do you think fits in a small group? Hint. It sure isn't
> all 300 on the maintainers list.

Not at all but again why not draft the offical "Linus IN/OUT Tree".

> > Ah.  So being listed in the maintainers list doesn't mean someone is actually
> > a maintainer it makes sense to forward patches to?
> 
> Sure it does.
> 
> It just doesn't mean that they should send stuff to _me_.

Some have gotten a strong grasp of the obvious nature of this point first
hand, regardless ...

Maybe you should consider taken an agreed code base migration change when
it is suggested and agreed upon, instead of ignoring comments and
suggestions for changes.  Just buy design when I get done w/ ATA and maybe
ATAPI so that it is clean and obvious to the reader, I would consider
tearing into the ABANDONED SCSI CORE.  However, I expect to find the same
uphill battle and may do it for the joy of exactness, but rediscover the
same problem of a global design change.

Something you need to understand, and I honestly expect you to ignore,
is a responsible an proper OS protects the hardware from accepting bad
command operations.  Given "LINUX" is a UNIX environment, that does not
give it the right to ignore comman sense.  However, to get along in your
world, all have accepted users are allowed and expect to have no
safeguards.  So when a problem comes up and it is ugly, it gets batted
down because the solution is wrong, and then quietly adopted without
acknowledgement the very solution proposed.

regards,

--andre

