Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSFSMFB>; Wed, 19 Jun 2002 08:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSFSMFA>; Wed, 19 Jun 2002 08:05:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64520 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317861AbSFSME6>; Wed, 19 Jun 2002 08:04:58 -0400
Date: Wed, 19 Jun 2002 08:00:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon 2000 XP MP nightmare
In-Reply-To: <200206161429.15653.snowwolf@one2one-networks.com>
Message-ID: <Pine.LNX.3.96.1020619075514.1119H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2002, Allan Sandfeld Jensen wrote:

> On Sunday 16 June 2002 10:30, Mark Hounschell wrote:

> > First make sure you have MP cpus NOT XP's. The XP's are not certified by
> > amd to run SMP. Second, try append="mem=nopentium" in your lilo.conf file.
> > I have a dual 1900+ MP box and without that I have random lockups also.
> >
> BS and FUD! 

What's wrong with this suggestion, from someone who believes it works?
Other than suggesting that it be hand entered instead of put in lilo?
Disabling 4M pages is unlikely to solve the problem, but (a) the poster
has tried it and I bet you haven't, and (b) all the things you suggest
require hardware action, while a boot option can be done with less effort
and chance of damage.

What you suggest is more likely to work, but I see no reason not to try
the simple fix first, with low time and effort budget.
 
> First try to remove one processor, and test the motherboard in single CPU 
> configuration. If you still see crashes replace the motherboard. I also have 
> a defective Asus A7M266-D. It crashes in any configuration of CPUs, power 
> supplies and video cards.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

