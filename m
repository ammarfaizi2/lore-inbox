Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSA2Xfz>; Tue, 29 Jan 2002 18:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287106AbSA2Xeb>; Tue, 29 Jan 2002 18:34:31 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:65169
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286647AbSA2XdO>; Tue, 29 Jan 2002 18:33:14 -0500
Message-Id: <200201292332.g0TNWwU21215@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Linus Torvalds <torvalds@transmeta.com>, Skip Ford <skip.ford@verizon.net>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 18:34:06 -0500
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201290914270.7701-100000@athlon.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201290914270.7701-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 12:36 pm, Linus Torvalds wrote:
> On Tue, 29 Jan 2002, Skip Ford wrote:
> > Linus Torvalds wrote:
> > [snip]
> >
> > > A word of warning: good maintainers are hard to find.  Getting more of
> > > them helps, but at some point it can actually be more useful to help
> > > the _existing_ ones.  I've got about ten-twenty people I really trust,
> > > and
> >
> > Then why not give the subsystem maintainers patch permissions on your
> > tree. Sort of like committers.  The problem people have is that you're
> > dropping patches from those ten-twenty people you trust.
>
> No. Ask them, and they will (I bet) pretty uniformly tell you that I'm
> _not_ dropping their patches (although I'm sometimes critical of them,
> and will tell them that they do not get applied).

Andre Hedrick, Eric Raymond, Rik van Riel, Michael Elizabeth Chastain, Axel 
Boldt...

> I think there is some confusion about who I trust. Being listed as
> MAINTAINER doesn't mean you are automatically trusted. The MAINTAINERS
> list is not meant for me _at_all_ in fact, it's meant more as one of the
> places for _others_ to search for a contact with.

Ah.  So being listed in the maintainers list doesn't mean someone is actually 
a maintainer it makes sense to forward patches to?

Are you backing away from the maintainer system, or were the rest of us 
misinterpreting what it meant all along?  Does being a maintainer mean you 
feel you have delegated any actual authority to them at all, or is it merely 
a third party tech support contact point?

You seem to be saying "send patches to maintainers, support the maintainers 
better, but don't expect me to necessarily take patches from them".  Who 
should patches be sent TO?

> Examples of people who I trust: Ingo Molnar, Jeff Garzik, Alan Cox, Al
> Viro, David Miller, Greg KH, Andrew Morton etc. They've shown what I call
> "good taste" for a long time. But it's not always a long process - some
> of you may remember Bill Hawes, for example, who came out of nowhere
> rather quickly.

So listed "maintainers" may need to forward patches to these people, and get 
them to sign off on them, in order to get their patches at least reviewed for 
inclusion into your tree?

If that's the process, fine.  I'm just trying to clarify what the process IS, 
other than spamming your mailbox with a cron job (as has been suggested and 
actually taken seriously as long as re-testing is also automated)...

> And there are categories of people who just own a big enough chunk that is
> separate enough that I trust them for that area: architecture maintainers
> etc tend to be here, as long as they only affect their own architecture.
>
> But you have to realize that there are a _lot_ of people on the
> maintainers list that I don't implicitly trust. And being loud and
> wellknown on the mailing lists or IRC channels doesn't make them any more
> trusted.

I've noticed that rather a lot of development seems to be moving to IRC.  How 
is this NOT to be interpreted as a lack of endorsement of the functionality 
of the other channels?  Is IRC "just nice", or does IRC address a problem not 
otherwise being addressed?

> 			Linus

Rob
