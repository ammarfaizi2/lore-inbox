Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSHIJ5Z>; Fri, 9 Aug 2002 05:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318218AbSHIJ5Z>; Fri, 9 Aug 2002 05:57:25 -0400
Received: from dclient217-162-176-39.hispeed.ch ([217.162.176.39]:25878 "EHLO
	alder.intra.bruli.net") by vger.kernel.org with ESMTP
	id <S318205AbSHIJ5Z>; Fri, 9 Aug 2002 05:57:25 -0400
From: "Martin Brulisauer" <martin@bruli.net>
To: o.pitzeier@uptime.at, ghoz@sympatico.ca, france@handhelds.org,
       Jay.Estabrook@compaq.com, pollard@tomcat.admin.navo.hpc.mil
Date: Fri, 9 Aug 2002 12:00:56 +0200
Subject: Re: kbuild 2.5.26 - arch/alpha
Reply-to: martin@bruli.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3D53AEF8.16231.E49799D@localhost>
References: <002b01c23279$84be70a0$1211a8c0@pitzeier.priv.at>
In-reply-to: <02072318292300.02533@shadowfax.middleearth>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2002, at 18:29, George France wrote:

> On Tuesday 23 July 2002 14:48, Oliver Pitzeier wrote:
> >
> > [ ... ]
> >
> > > You have made me aware that we have unintentionally created a
> > > private sort of club.  I apologize. This will have to be corrected.
> >
> > That's not what I expected to read...
> > I think that this "private club" is not wrong at all... It just would
> > be nicer if there would be some kind of batch every week where all
> > alpha users/developers get a mail...
> 
> I agree. We should send a weekly e-mail with the current status.

I did not see any news on the alpha/linux topic in lkml lately.

What is the way to keep in touch with the "private club" to help/
assist in getting further to a running 2.5.x kernel on alpha? I
am still on 2.4.18 on my test system.

Did anybody use gcc-3.0.x or gcc-3.1? With gcc-3.0.4 I 
successfully built 2.4.18 but some applications don't run
correctly (eg. MySQL -> Parser). Is the kernel compilable
with gcc-3.1? Today I am using gcc-2.95.3 and I think is
ok; better than egcs (generates less unaligned traps at
runtime without changing the source).


Greetings,
Martin

