Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265551AbSKABYP>; Thu, 31 Oct 2002 20:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSKABXo>; Thu, 31 Oct 2002 20:23:44 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21777 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265552AbSKABXO>; Thu, 31 Oct 2002 20:23:14 -0500
Date: Thu, 31 Oct 2002 20:29:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
In-Reply-To: <1036064925.8584.55.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021031202442.22444B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Oct 2002, Alan Cox wrote:

> On Thu, 2002-10-31 at 00:47, Dave Jones wrote:

> > I'd agree that it would make sense to at least remove some of the
> > lesser maintained drivers. Linus didnt seem to keen on the idea
> > last time I proposed it.
> 
> OSS hasnt worked on SMP between about 2.5.35 and 2.5.44 so I dont think
> its that major 8)

Thank you, since all the systems I have been using for 2.5 testing are
SMP, I just thought sound was broken in general. And still may be, since I
found that some audio CD's I burned with 2.5 are just noise while the same
hardware burned CD's from the same batch of blanks using 2.4.19+patches.
Using SMP. I'll try a uni burn tomorrow.
 
> Mostly I'm working on the NCR5380 first. That happens to be attached to
> my scanner so spinning for 15 seconds in IRQ context is annoying me 8)

I can't get the aha142x working either, if you're looking for stuff to do
;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

