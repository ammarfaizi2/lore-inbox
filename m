Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVLHA7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVLHA7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 19:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVLHA7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 19:59:07 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:5249 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030342AbVLHA7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 19:59:06 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Kasper Sandberg <lkml@metanurb.dk>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20051206T220254-691@post.gmane.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
	 <20051206030828.GA823@opteron.random>
	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>
	 <1133869465.4836.11.camel@laptopd505.fenrus.org>
	 <4394ECA7.80808@didntduck.org>
	 <1133880581.4836.37.camel@laptopd505.fenrus.org>
	 <loom.20051206T220254-691@post.gmane.org>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 01:58:56 +0100
Message-Id: <1134003536.8162.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 21:39 +0000, Nicolas Mailhot wrote:
> Arjan van de Ven <arjan <at> infradead.org> writes:
> 
> > There are lots of opportunities to put pressure on vendors, either
> > direct or indirect. Nvidia has a support department. If they get enough
> > calls / letters about their solution not being good enough, they're more
> > likely to consider the rearchtect solution. 
> 
> Indeed a single centralized complete online hardware database (with hardware
> rated according to driver support level) would go a long way to put real
> pressure on vendors. We know how to set up one for gnome/kde themes surely it'd
> be possible to create one for hardware ? (not the current nebulae of
> semi-complete overlapping projects, menuconfig entries, blog notes, linux-kernel
> notifications)
> 
> But this requires _kernel_ _people_ cooperation. You're the ones who know what
> works and what doesn't. You're the ones who know which corporations are helpful.
> You're the first people users contact when they have new hardware they'd like to
> make work. You're the ones who know which drivers you're currently working on.
> 
> The PCI ID database can be maintained without kernel people intervention. A
> "linux-friendly hardware" database can not.
> 
> Right now getting hardware advice is a long and painful process. Hardware that
> works is only semi-documented. Hardware which doesn't isn't at all. Users have
> to comb numerous on-line databases and mail archives (full of obsolete/wrong
> info) to spec a single linux-friendly system. Few people bother to answer
> hardware advice requests on mailing lists.
i disagree, you make it sound like it takes weeks of effort to find out
which stuff works on linux, and that basically you have to be lucky to
find it at all...

basically the only thing that doesent work (i dont count binary-only
solutions working) is nvidia and ati.

other mainstream stuff just works.. i never have to look for hardware
when i buy, it simply works (whereas the few times i have put together a
system that should run windows hardware has often not worked very well..
if at all)

i have also converted a fair share of windows users to linux, where they
have simply gone to the store and bought their pc, and it has never
given problems (granted, there i have installed nvidia driver even
though its closed source stuff.)

as it is today, the end user doesent really have much of a problem.

> 
> Linux users could reward friendly hardware makers if only you bothered to point
> them the right way. That is :
> - list publicly working hardware as soon as the kernel driver is ready
> - list publicly non-working hardware as soon as someone enquires for a reference
> which does not work.
i agree, stupid vendors which ignores linux drivers should be pointed
out, and vendors which either give specs, develop drivers or help doing
so should also be pointed out.

> 
> There's no magic.
> 
> Hardware makers do all kinds of stupid stuff to please review sites. Review
> sites are influential because lots of people buy stuff based on their advice.
> Lots of people follow review site advice because review sites centralize info
> about all kinds of hardware, so you don't have to comb the web to find it.
> 
> As Groklaw has shown - if you manage to do complete coverage of a subject, even
> an obscure subject like IP laws or Linux drivers, you suddenly get quoted
> everywhere. But to reach that stage you mustn't go halfways but record
> meticulously info about all the hardware you know of.
> 

