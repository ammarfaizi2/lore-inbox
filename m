Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSHMQdm>; Tue, 13 Aug 2002 12:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318209AbSHMQdm>; Tue, 13 Aug 2002 12:33:42 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:414 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S318196AbSHMQdk>; Tue, 13 Aug 2002 12:33:40 -0400
Message-Id: <200208131636.g7DGaUZ265560@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: large page patch (fwd) (fwd)
Date: Tue, 13 Aug 2002 07:36:24 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, frankeh@watson.ibm.com,
       davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
References: <1029113179.16236.101.camel@irongate.swansea.linux.org.uk> <200208131340.g7DDeEb207512@pimout2-ext.prodigy.net> <1029251186.22847.39.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1029251186.22847.39.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 August 2002 11:06 am, Alan Cox wrote:
> On Tue, 2002-08-13 at 09:40, Rob Landley wrote:
> > Unfortunately, the maintainer of the GPL is Stallman, so he's the logical
> > guy to spearhead a "GPL patent pool" project, but any time anybody
> > mentions the phrase "intellectual property" to him he goes off on a
> > tangent about how you shouldn't call anything "intellectual property", so
> > how can you have a discussion about it, and nothing ever gets done.  It's
> > FRUSTRATING to see somebody with such brilliant ideas hamstrung not just
> > by idealism, but PEDANTIC idealism.
>
> Richard isnt daft on this one. The FSF does not have the 30 million
> dollars needed to fight a *single* US patent lawsuit. The problem also
> reflects back on things like Debian, because Debian certainly cannot
> afford to play the patent game either.

Agreed, but they can try to give standing to companies that have either the 
resources or the need to do it themselves, and also to placate people who see 
patent applications by SGI and Red Hat as evil proprietary encroachment 
rather than an attempt to scrape together some kind of defense against the 
insanity of the patent system.

Like politics: it's a game you can't win by ignoring, you can only try to use 
it against itself.  The GPL did a great job of this with copyright law: it 
doesn't abandon stuff into the public domain for other people to copyright 
and claim, but keeps it copyrighted and uses that copyright against the 
copyright system.  But at the time software patents weren't enforceable yet 
and I'm guessing the wording of the license didn't want to lend credibility 
to the concept.  This situation has changed since: now software patents are 
themselves an IP threat to free software that needs a copyleft solution.

Releasing a GPL 2.1 with an extra clause about a patent pool wouldn't cost 
$30 million.  (I.E. patents used in GPL code are copyleft style licensed and 
not BSD style licensed: they can be used in GPL code but use outside it 
requires a seperate license.  Right now it says something like "free for use 
by all" which makes the mutually assured destruction people cringe.)

By the way, the average figure I've heard to defend against a patent suit is 
about $2 1/2 million.  That's defend and not pursue, and admittedly that's 
not near the upper limit, but it CAN be done for less.  And what you're 
looking for in a patent pool is something to countersue with in a defense, 
not something to initiate action with.  (Obviously, I'm not a professional 
intellectual property lawyer.  I know who to ask, but to get more than an off 
the cuff remark I'd have to sponsor some research...)

Last time I really looked into all this, Stallman was trying to do an 
enormous new GPL 3.0, addressing application service providers.  That seems 
to have fallen though (as has the ASP business model), but the patent issue 
remains unresolved.

Red Hat would certainly be willing to play in a GPL patent pool.  The 
statement on their website already gives blanket permission to use patents in 
GPL code (and a couple similar licenses; this would be a subset of the 
permission they've already given).  Red Hat's participation might convince 
other distributors to do a "me too" thing (there's certainly precedent for 
it).  SGI could probably be talked into it as well, since they need the 
goodwill of the Linux community unless they want to try to resurrect Irix.  
IBM would take some convincing, it took them a couple years to get over their 
distaste for the GPL in the first place, and they hate to be first on 
anything, but if they weren't first...  HP I haven't got a CLUE about with 
Fiorina at the helm.  Dell is being weird too...

Dunno.  But ANY patent pool is better than none.  If suing somebody for the 
use of a patent in GPL code terminates your right to participate in a GPL 
patent pool and makes you vulnerable to a suit over violating any patent in 
the pool, then the larger the pool is the more incentive there is NOT to 
sue...

Rob
