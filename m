Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311130AbSCMTpv>; Wed, 13 Mar 2002 14:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311128AbSCMTpl>; Wed, 13 Mar 2002 14:45:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56841 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311119AbSCMTpa>; Wed, 13 Mar 2002 14:45:30 -0500
Date: Wed, 13 Mar 2002 14:43:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <20020312172134.A5026@ucw.cz>
Message-ID: <Pine.LNX.3.96.1020313144211.4797B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Vojtech Pavlik wrote:

> PIIX and ICH are pretty crazy hardware from the design perspective, very
> legacy-bound back to the first Intel PIIX chip. And the driver for these
> in the kernel has similarly evolved following the hardware. However, it
> doesn't seem to be wrong at the first glance. Nevertheless, I'll take a
> look at it. Unfortunately, I don't have any Intel hardware at hand to
> test it with.

I'm not sure "evolved" is the term you want, allow me to suggest
"mutated."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

