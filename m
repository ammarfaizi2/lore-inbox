Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281416AbRLADD4>; Fri, 30 Nov 2001 22:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281427AbRLADDh>; Fri, 30 Nov 2001 22:03:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37902 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281416AbRLADDb>; Fri, 30 Nov 2001 22:03:31 -0500
Date: Fri, 30 Nov 2001 18:57:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tim Hockin <thockin@hockin.org>
cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <200112010202.fB122bE20177@www.hockin.org>
Message-ID: <Pine.LNX.4.33.0111301825150.1296-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Nov 2001, Tim Hockin wrote:
>
> > I'm deadly serious: we humans have _never_ been able to replicate
> > something more complicated than what we ourselves are, yet natural
> > selection did it without even thinking.
>
> a very interesting argument, but not very pertinent - we don't have 10's of
> thousands of year or even really 10's of years.  We have to use intellect
> to root out the obviously bad ideas, and even more importantly the
> bad-but-not-obviously-bad ideas.

Directed evolution - ie evolution that has more specific goals, and faster
penalties for perceived failure, works on the scale of tens or hundreds of
years, not tens of thousands. Look at dog breeding, but look even more at
livestock breeding, where just a few decades have made a big difference.

The belief that evolution is necessarily slow is totally unfounded.

HOWEVER, the belief that _too_ much direction is bad is certainly not
unfounded: it tends to show up major design problems that do not show up
with less control. Again, see overly aggressive breeding of some dogs
causing bad characteristics, and especially the poultry industry.

And you have to realize that the above is with entities that are much more
complex than your random software project, and where historically you have
not been able to actually influence anything but selection itself.

Being able to influence not just selection, but actually influencing the
_mutations_ that happen directly obviously cuts down the time by another
large piece.

In short, your comment about "not pertinent" only shows that you are
either not very well informed about biological changes, or, more likely,
it's just a gut reaction without actually _thinking_ about it.

Biological evolution is alive and well, and does not take millions of
years to make changes. In fact, most paleolontologists consider some of
the changes due to natural disasters to have happened susprisingly fast,
even in the _absense_ of "intelligent direction".

Of course, at the same time evolution _does_ heavily tend to favour
"stable" life-forms (sharks and many amphibians have been around for
millions of years). That's not because evolution is slow, but simply
because good lifeforms work well in their environments, and if the
environment doesn't change radically they have very few pressures to
change.

There is no inherent "goodness" in change. In fact, there are a lot of
reasons _against_ change, something we often forget in technology. The
fact that evolution is slow when there is no big reason to evolve is a
_goodness_, not a strike against it.

> > Quite frankly, Sun is doomed. And it has nothing to do with their
> > engineering practices or their coding style.
>
> I'd love to hear your thoughts on why.

You heard them above. Sun is basically inbreeding. That tends to be good
to bring out specific characteristics of a breed, and tends to be good for
_specialization_. But it's horrible for actual survival, and generates a
very one-sided system that does not adapt well to change.

Microsoft, for all the arguments against them, is better off simply
because of the size of its population - they have a much wider consumer
base, which in turn has caused them largely to avoid specialization. As a
result, Microsoft has a much wider appeal - and suddenly most of the
niches that Sun used to have are all gone, and its fighting for its life
in many of its remaining ones.

Why do you think Linux ends up being the most widely deployed Unix? It's
avoided niches, it's avoided inbreeding, and not being too directed means
that it doesn't get the problems you see with unbalanced systems.

Face it, being one-sided is a BAD THING. Unix was dying because it was
becoming much too one-sided.

Try to prove me wrong.

		Linus

