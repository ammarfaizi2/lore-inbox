Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314136AbSDVMGd>; Mon, 22 Apr 2002 08:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSDVMGc>; Mon, 22 Apr 2002 08:06:32 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:34822 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314136AbSDVMGb>; Mon, 22 Apr 2002 08:06:31 -0400
Date: Mon, 22 Apr 2002 14:06:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Jeff Garzik <garzik@havoc.gtf.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <20020421123257.A4479@havoc.gtf.org>
Message-ID: <Pine.LNX.4.21.0204221354350.30057-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jeff Garzik wrote:

> > He made his intention very clear, you are interpreting something in
his
> > action, that simply isn't there.
>
> How can one misinterpret the action of "<this> is my ideology.
> this document offends me.  I remove it."?

If "ideology" means to state a different opinion, then I'm guilty too,
I'm an ideologist and proud of it. Please get your terminology straight
before you make such accusations.

> If you want to be really semantic, Daniel's patch was an attempt to
> censor, not censorship itself.  But when it's a GPL'd document that
> I wrote, I'll treat them equally.

One doesn't "attempt to censor" by publicly announcing it. Get real,
this is getting ridiculous.

> > kernel development with bk requires net access
>
> No it doesn't

What you describe in the document does.

> > Personally I don't care what tools people use, but I'm getting
> > concerned, when a nonfree tool is advertised as tool of choice for
> > kernel for development as if there would be no choice.
>
> Linus, myself, and others _repeatedly_ say that BitKeeper is _not_
> the sole means of submitting patches.  Thus actively and repeatedly
> disputing "as if there would be no choice."

I was talking about SCM systems. The current situations favours bk and
you currently doing your best to piss anyone off, who cares about free
software.

>  Otherwise, kernel hackers
> would have written a BK alternative by now, instead of simply whining.

Nobody is whining here. I accept Linus' decision for bk and I understand
why. I'm not entirely happy about it, but there is currently not much I
can do about it and it's still better than using no SCM system at all.

> > But there isn't anything like that, so Joe Hacker
> > has to think he should use bk as SCM to get his patch into the kernel,
> > because Linus is using it.
>
> If Linus and others repeatedly claim this is untrue, and repeatedly
> prove this by taking GNU patches, your statement is utter fantasy.

Again, I was more talking about SCM systems here. I don't care, what
tools you are using, but we should avoid giving the impression, that
Joe Hacker should use bk, because Linus is using it.
You and Linus may only care about hacking for fun, but other people also
care about the freedom to hack. Recent developments in the US and Europe
should have made clear that this is necessary. Nobody wants to make Larry
the bad guy here, but is on the other hand a little respect really too
much to ask for, when people critize the usage of bk, that they not
automatically get branded as bunch of fanatics with some strange
"ideology"? 
Could we at least add something like below as a compromise (it's only a
suggestion and not an attempt to brainwash or something like that). It's
not enough to assume that people know that they have a choice, we have to
tell them that and besides of some statements on the LKML, I can't find it
officially documented anywhere:

Unlike Linux itself bk is not free software, but it was choosen by Linus
and other developers because of it qualities as distributed source code
management system. Before you start using bk you should have carefully
read http://www.bitkeeper.com/Sales.Licensing.Free.html and decided for
yourself whether these conditions are acceptable. Alternatively the latest
kernel sources will also always be available at www.kernel.org. If you
require a source code management system, you might also consider one of
the freely available systems.

bye, Roman

