Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSFVMlQ>; Sat, 22 Jun 2002 08:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSFVMlP>; Sat, 22 Jun 2002 08:41:15 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:9491 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S311710AbSFVMlO>; Sat, 22 Jun 2002 08:41:14 -0400
Date: Sat, 22 Jun 2002 14:41:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Larry McVoy <lm@bitmover.com>
cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
In-Reply-To: <20020621182337.T23670@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0206221423540.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Jun 2002, Larry McVoy wrote:

> On Fri, Jun 21, 2002 at 09:07:10PM -0400, Horst von Brand wrote:
> > Right. If they had designed it for 4/8 CPUs from the start, they would
> > surely have gotten it dead wrong. Just to find out how wrong around now...
>
> I couldn't disagree more.  The reason that all the SMP threaded OS's start
> to suck is that managers say "Yeah, one CPU is good but how about 2?"  Then
> a year goes by and then they say "Yeah, 2 CPUs are good but how about 4?".
> Etc.  So the system is never designed, it is hacked.  It's no wonder they
> suck.

That's the important difference here, we have no managers forcing us to
specific goals. We have the time to develop a good solution, we are not
forced to accept a solution which sucks. We have the freedom to constantly
break the kernel and we don't have to maintain backwards compability,
which especially with regard to locking would really suck.

bye, Roman

