Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVE2Tu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVE2Tu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 15:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVE2Tu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 15:50:58 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:28339 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261421AbVE2Tuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 15:50:35 -0400
Date: Sun, 29 May 2005 13:52:45 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
cc: Lee Revell <rlrevell@joe-job.com>, Bill Huey <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance 
In-Reply-To: <200505291750.j4THoUWW010374@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.61.0505291223120.12903@montezuma.fsmlabs.com>
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
 <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
 <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>
 <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au>
 <20050528054503.GA2958@nietzsche.lynx.com> <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com>
 <1117334933.11397.21.camel@mindpipe> <Pine.LNX.4.61.0505282054540.12903@montezuma.fsmlabs.com>
 <200505290408.j4T487n6024489@turing-police.cc.vt.edu>           
 <Pine.LNX.4.61.0505290856220.12903@montezuma.fsmlabs.com>
 <200505291750.j4THoUWW010374@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Valdis,

On Sun, 29 May 2005 Valdis.Kletnieks@vt.edu wrote:

> As amply shown by the Ardour and linux-audio crowds, the *MAJOR* thing keeping
> realtime apps from spreading further is the lack of usable RT support in CTOS
> operating systems.  Yes, you *can* do realtime audio - if you're willing to not
> use a common operating system and run some specialized RTOS instead.  This is
> frequently a show-stopper for small-time use - if there's an additional $5K
> cost to getting and installing an RTOS (quite likely you need a new computer,
> or redo the one you have to dual-boot), it may not be a problem for a large
> recording studio - but it *is* a problem for a small studio or a home user.
> So you end up with "The 150 places that buy 48-channel mixers are using RT,
> but the 40,000 people who buy 4/8 channel mixers aren't" - by your standards,
> nobody's interested in 48-channel mixing boards either.

I seem to have gotten you rather excited, you've actually gone as far as 
creating a strawman argument for my allegedly "strawman" statement. What 
i originally stated was that media applications are not common place as far 
as _hard_ realtime systems are concerned, this was in reply to Bill's 
emphasis on media applications. Now i'm not trying to undermine the 
audiophiles' goals or aspirations and i do indeed see the benefits for 
them but in the event of Linux becoming an RTOS, the main fields 
of interest wouldn't be from media application providers (even if there 
certainly will be an increase in their interest).

> So tell me - who was using SMP with large numbers of processors *before*the
> Linux kernel?  Hmm.. You could buy an SGI Onyx.  A Sun E10K.  The IBM gear.
> And for some odd reason, there wasn't many sites that just weren't doing
> SMP - it wasn't that long ago that a 48-CPU Sun was enough to get you on the
> Top500 supercomputer list.  Now everybody and their pet llama has a 128-node
> system, it seems....

Terribly sorry old bean, but Linux isn't the center of the universe. I'm 
afraid Linux wasn't the push factor which led to the proliferation of 
multiprocessor systems.

> Large-scale SMP, realtime, whatever.  It doesn't matter - you're pointing at it and
> saying "But nobody *uses* it" when nobody can afford the technology, when there's
> plenty of people lining up and saying "We *would* be using it if it were accessible".

No, i never said that, please look at the original statement and the 
context to which it was based on.

Cheers,
	Zwane

