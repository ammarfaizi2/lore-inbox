Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTFYARs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 20:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTFYARs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 20:17:48 -0400
Received: from mail.casabyte.com ([209.63.254.226]:56593 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S263597AbTFYARK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 20:17:10 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Larry McVoy" <lm@bitmover.com>, "Werner Almesberger" <wa@almesberger.net>
Cc: "Stephan von Krawczynski" <skraw@ithnet.com>, <miquels@cistron-office.nl>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Date: Tue, 24 Jun 2003 17:31:06 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGIEBMDBAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030620152447.GB17563@work.bitmover.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the theoretical sense, it is easy to create a world that is "completely"
based on open source.  Or at least completely enough that the closed source
elements, when measured by size or volume or feature list, are so deep into
the noise floor as to be meaningless.

The thing is, the first step in that evolution is a human engineering
problem.

The open source model is basically a barter system where the central
exchange is an open and unwatched pit in the center of town.  When all the
participants finally "wise up" to the particular realities of that barter
system then the open source behavior becomes rational.

The fine points that confuse businesses are:

1) You can not "deplete" the pit.  Anything thrown into the pit once can be
removed "an infinite number of times."  This is why the pit doesn't need to
be guarded or administrated.  This is why we don't need a pit boss.

2) You agree, in taking from the pit, to "pay back" by returning to the pit
your improvements.  This is a simple business arrangement.  As "the company"
learns that it isn't "giving away it's hard work" by open sourcing things,
the model starts to work.  The fact is that companies *AREN'T* "giving away"
their hard work, they are "paying (back) their hard work" for the privilege
of using the infinitely larger pool of "hard work" of others.  This has an
inherent profit-and-loss statement to beat all priors.  I can "borrow" the
*entire* *value* of the pit against my eventual contribution of whatever
patch, improvement, new paradigm, spare idea, or spare server space I *may*
eventually have, all without ever having to worry about a bill collector.
That is *pure profit*.  An infinite number of workers for zero payroll up
front and double-value amortization of the work (payroll) I had to pay for
anyway, when the enhancement is returned to the pit.

3) Nobody is keeping score.  This is the hardest part for a business to
swallow.  Money is how businesses keep score, but in this barter system
there is no depletion, no "take away", only "share", and the value being
exchanged is "man thought hours" which is not money.  How do you express
that to shareholders?  It's doable, but in a short-sighted post-80's, no
such thing as the long view version of business savvy we live under it's
damn hard to get the message through.

4) Software is *not* a viable product.  There are all sorts of viable
products surrounding software (devices, services, integration tasks,
content) but the only real "bubble" was the 25 years where the software was
itself a commodity.  We are left with a legacy where it still "feels like"
there is a dream business somewhere in "start software company" "???"
"profit!" but it just isn't true.  Software for software's sake is the
idea-farm equivalent of "Archie McPhee" junk.  New software is "novel" but
anybody who sees the bobbing bird that "drinks" will either think it is
interesting but transient phenomena and buy it if it is *super cheap* or
they will see how it works and go out and build their own.

You have made the *GRAVE* mistake of reversing the cause and the effect in
formulating your observations.  OSS versions of proprietary systems are not
created because the creators can not think of new things on their own.  OSS
version of proprietary systems are created because either the original is
tragically flawed and they cannot get the original company to fix it at
"proper novelty prices"; or because the rest of the world wants to keep some
odd thing afloat and the proprietary system can not be properly extended to
work "in the real world".

Consider SAMBA.  This product doesn't exist because the SMB file system is
somehow excellent technology.  The SMB file system is terribly slow and
awkward.  It is "bad tech".  SAMBA exists because windows can not be easily
and rationally extended to work with NFS for "novelty prices" (neither in
man hours or green-folding-applause) and enough people want to bring the
(increasingly) niche gaming machine or must-be-windows application files out
into the real world.

(Remember this isn't a discussion of "Market Share", this is a discussion of
who is sponging what ideas from whom and where the "natural business model"
is for Open Source, so don't criticize my discussion of M.S. ware as
"niche".  Compare the several hindered or whatever people working on, or
with can-modify-and-distribute access to the windows core/kernel/etc to the
"everybody plus dog" community with can-modify-and-distribute access to the
Linux kernel.  By definition, in terms of creative effort available, any
closed source element occupies a niche exactly as large as the corporate
developer staff.  So "niche"....)

If windows were to be open sourced tomorrow, a year from now it would have
EXT3 and NFS and RiserFS and functioning Kerberos and NIS and so forth, and
SAMBA would be in decline because the gaping security wound that is "Windows
Networking" would be quickly and easily displaced with some SSH tunnel and a
Windows Networking compatibility layer for that legacy stuff.

Further, if the creative effort didn't have to be dissipated (like so much
waste heat) in the effort to crack and hack into the various
low-mental-value but well-secured-from-public-understanding niche-ware we
would have something better than SMB *or* NFS by now.

When nearly nobody *could* program because nearly nobody had compilers and
know-how, that knowledge and access was a dear commodity commanding extreme
prices in a closed market.  Now everybody and their brother thinks they can
program better than everybody else, and poor Linus has to *fight* to keep
the crap-ware from creeping into his domain.

The odd paradox is that even the crap-ware has value to some audience.

The other odd paradox is that now that the windows market has eaten alive
the various basic and C and C++ compilers that were as pervasive as vermin,
the children today don't have that tinker-giest opportunity any more.  The
current Junior-High tech head thinks he is 3l33t because he can copy things
onto his web page.  At least the game-mod systems let some of them see "real
programming" "for free".  Were I a conspiracy theorist this point would
bother me.  I am, however, a realist, and see that the reason the decline of
the GW-Basics of the world is because the uber-mench who think that all
software must have cash value to be wrung from each byte of code, poisoned
their own well by hiding and restricting their future cash crop of cheap
labor.

Closed source is self-punishing, but the learning curve time is currently
somewhere about 35 years per-cycle.  (e.g. we are nearing the end of the
first full iteration.)

The feedback loop is tightening up though, so as the model ages and becomes
more absurd, people will become more clueful.

The current "patent an idea" debacle is the third-to-last ditch effort to
sustain the closed source money bonanza.  But it too shall pass (after it
has left a wake of stupidity, ire, and ruin across our economy... 8-)

As I said in a previous post in this forum, "Monkey See, Monkey Do" and if
you bet against that essential truth, make sure it is a short term bet, and
that you can sell your interest to a backer to take the soaking on the long
term.  Even describing the rough outlines of a software idea is enough to
get the good parts developed out from under you.  No software concern that
wants to have people use its product, and who has a product that doesn't
suck, can get more than two user-weeks into release before someone is
already mapping the good and bad parts of the system with an eye towards
renovation.

Ideas can not be "stolen" unless you hammer out the brains of the original
thinker and then burn and burry the body.  If I "take your idea and run with
it" I haven "stolen" a damn thing, because you still have your idea too.
Ideas will be refined and reconsidered by every person who encounters them.
Nature of the (man) beast.  There is no licensing model or moral tone or
degree of unmitigated whining about the fairness of life that can change
that.

You want to base a business model on the idea that you are going to put out
good software that will remain untouched and unmimiced in the market place?

Really?

You might as well base your business plan on your patented sure fire way to
make money in a world without sex, porn, masturbation, drinking beer, eating
chocolate and gossiping...

How about a business plan where the good TV shows stay on the air and the
cheap rip-offs of the latest reality shows *automatically* die stillborn on
the network boardroom floor before the first dollar is spent on production?

Get serious, we are people and this is earth...


Rob.



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Larry McVoy
Sent: Friday, June 20, 2003 8:25 AM
To: Werner Almesberger
Cc: Larry McVoy; Stephan von Krawczynski; miquels@cistron-office.nl;
linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]


On Fri, Jun 20, 2003 at 12:18:34PM -0300, Werner Almesberger wrote:
> Larry McVoy wrote:
> >     The reason I take this point of view, unpopular though it may be,
> >     is that I see open source as basically parasitic.
>
> Think of it as a child that's growing up. For quite a while, it
> will just draw resources from the parents, add little work or
> innovations, and will have considerably less economical power
> than the parents.

That's a perfectly fine thing, it's the normal circle of life and to
some extent I think we're in agreement.

The point I'm trying to make is could we please think about how create
a world that is sustainable and based completely on open source?  There
are lots of people who say you can't trust anything but open source, the
companies behind are evil corporate monsters just waiting to jump out
from under your bed at night and grab you (sorry, couldn't resist).
Seriously, if what you want is an all open source all the time, which
would be fantastic in some sense, then how about a plan that shows how
that will work?  Saying that open source is a child growing is a nice
analogy but what's the grown up child look like?  Is this going to just
be like the 60's flower children that grow up and turn into their parents
after all?
--
---
Larry McVoy              lm at bitmover.com
http://www.bitmover.com/lm
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

