Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291247AbSCEWSE>; Tue, 5 Mar 2002 17:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291484AbSCEWRy>; Tue, 5 Mar 2002 17:17:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22022 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291247AbSCEWRp>; Tue, 5 Mar 2002 17:17:45 -0500
Date: Tue, 5 Mar 2002 17:16:06 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <1015102702.14000.17.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1020305165008.28458C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Mar 2002, Robert Love wrote:

> On Sat, 2002-03-02 at 15:47, Andrea Arcangeli wrote:
> 
> > On Sat, Mar 02, 2002 at 09:57:49PM -0200, Denis Vlasenko wrote:
> >
> > > If rmap is really better than current VM, it will be merged into head 
> > > development branch (2.5). There is no anti-rmap conspiracy :-)
> > 
> > Indeed.
> 
> Of note: I don't think anyone "loses" if one VM is merged or not.  A
> reverse mapping VM is a significant redesign of our current VM approach
> and if it proves better, yes, I suspect (and hope) it will be merged
> into 2.5.

  As noted, I do use both flavors of VM. But in practical terms the delay
getting the "performance" changes, rmap, preempt, scheduler, into a stable
kernel will be 18-24 months by my guess, 12-18 months to 2.6 and six
months before Linus opens 2.7 and lets things gel. So to the extent that
people who would be using those kernels get less performance, or less
responsiveness, I guess they are the only ones who lose.

  Feel free to tell me it won't be that long or that 2.5 will be stable
enough for production use, but be prepared to have people post release
dates from 12 to 2.0, 2.0 to 2.2, 2.2 to 2.4, and just laugh about
stability. There are a lot of neat new things in 2.5, and they will take
relatively a long time to be stable.  No one wants to limit the
development of 2.5, or at least the posts I read are in favor of more
change rather than less.

  In any case, I agree there are no "losers" in that sense.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

