Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbSIWTST>; Mon, 23 Sep 2002 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSIWTRa>; Mon, 23 Sep 2002 15:17:30 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21768 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261340AbSIWTQ5>; Mon, 23 Sep 2002 15:16:57 -0400
Date: Mon, 23 Sep 2002 15:14:38 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Peter Waechtler <pwaechtler@mac.com>
cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <4FBEDDB0-CEEB-11D6-8873-00039387C942@mac.com>
Message-ID: <Pine.LNX.3.96.1020923150331.13351A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Peter Waechtler wrote:

> Am Montag den, 23. September 2002, um 12:05, schrieb Bill Davidsen:
> 
> > On Sun, 22 Sep 2002, Larry McVoy wrote:
> >
> >> On Sun, Sep 22, 2002 at 08:55:39PM +0200, Peter Waechtler wrote:
> >>> AIX and Irix deploy M:N - I guess for a good reason: it's more
> >>> flexible and combine both approaches with easy runtime tuning if
> >>> the app happens to run on SMP (the uncommon case).
> >>
> >> No, AIX and IRIX do it that way because their processes are so bloated
> >> that it would be unthinkable to do a 1:1 model.
> >
> > And BSD? And Solaris?
> 
> Don't know. I don't have access to all those Unices. I could try FreeBSD.

At your convenience.
 
> According to http://www.kegel.com/c10k.html  Sun is moving to 1:1
> and FreeBSD still believes in M:N

Sun is total news to me, "moving to" may be in Solaris 9, Sol8 seems to
still be N:M. BSD is as I thought.
> 
> MacOSX 10.1 does not support PROCESS_SHARED locks, tried that 5 minutes 
> ago.

Thank you for the effort. Hum, that's a bit of a surprise, at least to me. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

