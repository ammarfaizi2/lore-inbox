Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbTCZSem>; Wed, 26 Mar 2003 13:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbTCZSem>; Wed, 26 Mar 2003 13:34:42 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61190 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261382AbTCZSel>; Wed, 26 Mar 2003 13:34:41 -0500
Date: Wed, 26 Mar 2003 13:41:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Ebling <aebling@tao-group.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reproducible terrible interactivity since 2.5.64bk2
In-Reply-To: <1048687681.6345.13.camel@spinel.tao.co.uk>
Message-ID: <Pine.LNX.3.96.1030326133818.8246A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Mar 2003, Andrew Ebling wrote:

> On Wed, 2003-03-26 at 11:51, Michal Schmidt wrote:
> 
> > I'm seeing serious interactivity problems in 2.5.65, 2.5.66, 2.5.65-mm4 
> > and 2.5.64-bk2.
> > I couldn't reproduce it on 2.5.64, 2.5.64-bk1.
> 
> I'm seeing similar on 2.5.66; xmms pauses when doing disk intensive
> tasks.

The only problem I see with X under 2.5.66 is that if you stop using it
long enough to have the screensaver kick in you can never unlock it. This
is in 2.5.6[56] and not in 2.5.59.

Having the screen locked certainly does hurt interactivity;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

