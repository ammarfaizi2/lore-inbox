Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262439AbREUKBx>; Mon, 21 May 2001 06:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262438AbREUKBn>; Mon, 21 May 2001 06:01:43 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:14596 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262439AbREUKBe>;
	Mon, 21 May 2001 06:01:34 -0400
Date: Mon, 21 May 2001 06:04:40 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy
Message-ID: <20010521060440.A1738@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com> <20010520164700.H4488@thyrsus.com> <20010520165952.A9622@devserv.devel.redhat.com> <25499.990399116@redhat.com> <20010520211346.A6170@thyrsus.com> <6382.990427297@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <6382.990427297@redhat.com>; from dwmw2@infradead.org on Mon, May 21, 2001 at 07:41:37AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> Because it is evidently confusing the issue. Perhaps because it sounds like 
> you were intending to feed Linus large patches for 2.5.[12] which effect 
> _both_ changes.

I'm going to give Linus the same installation kit the people working with CML2
have now.  That will include both the CML2 engine and the rulesfiles.
 
> Have patience - let the less contentious part of CML2 go in first, and then
> we can deal with the other stuff later, once CML2 has been accepted (however
> grudgingly in some cases) by developers.

I don't think there is a "less contentious" part.  The same people who bitched
about the engine are now bitching about the changes I'm contemplating in the
rulesfiles.  It seems clear to me that their attitude, in general, has little
to do with technical specifics of the engine or rulesets and everything to
do with resistance to change in general and fear of losing control and/or
hard-won implicit knowledge about the old system.

I can sympathize with their upset, but I don't intend to let it stop
me.  And since I'm going to have these people angry at me unless I
give up entirely, I figure I have little to lose by steaming ahead full.

> > The engine is working.  Why is it not yet time to discuss ruleset design
> > and modes?
> 
> For a man who claims to hack social systems, that's an incredibly naïve 
> question.

You think so, eh?  Heh.  Experience has taught me that sometimes
hacking social systems requires a certain amount of sheer
bloodymindedness.

See, I've already written off the chronic bellyachers.  Since I can't
please them without scrapping the whole plan, I'm going to ignore
them.  In particular, anybody who repeated "fsck Python..." after Linus
ruled that Python is not an issue and Greg Banks announced the C
implementation of CML2 has got a sufficiently severe case of
rectocranial insertion that they've defined themselves out of the
conversation.

Instead I'll take my cues from people like you and Ray Knight and Tom
Rini and Alan Cox and Martin Schwidefsky who are actually offering
help and constructive criticism.  (Arjan de Ven is trying but he's not
up to speed on the language yet.)  I trust you've noticed by now that
I *do* listen very carefully in that situation, and I follow up with
questions when I'm not sure what people are trying to tell me.  I'll
keep doing that.

Eventually the bellyachers may get a message about what kind of behavior
gains them influence and what kind loses them influence.  That's a
social-systems hack of a sort ;-).
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

I don't like the idea that the police department seems bent on keeping
a pool of unarmed victims available for the predations of the criminal
class.
         -- David Mohler, 1989, on being denied a carry permit in NYC
