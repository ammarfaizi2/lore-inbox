Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTKTXzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTKTXzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:55:51 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9230 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264077AbTKTXyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:54:50 -0500
Date: Thu, 20 Nov 2003 18:15:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Matt Mackall <mpm@selenic.com>
cc: Nick Piggin <piggin@cyberone.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
In-Reply-To: <20031120065241.GF22139@waste.org>
Message-ID: <Pine.LNX.3.96.1031120180619.11021D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Nov 2003, Matt Mackall wrote:

> Scenario to think about: an NDIS driver layer ends up getting firmed
> up and debugged and when the next generation of wireless appears,
> basically all vendors go the easy route and only ship NDIS drivers, no
> specs, and buggy as usual. Then they say hey, this worked out well,
> might as well do this with gigabit. Meanwhile, hardware's changing so
> quickly that by the time we manage to reverse-engineer any of this
> stuff (provided the legal climate allows it), it's already off the
> shelves. Two to three years from now, it's impossible to build a
> decent server or laptop that doesn't have bug-ridden, untested, low
> performance network drivers and all the reputation Linux has for being
> a good network OS goes down the tubes. It's safe to assume that
> latency and stability will go all to hell as well.
> 
> An open operating system without open drivers is pointless and if we
> don't do something about all this binary crap soon, the above scenario
> -will- play out. Expect SCSI and perhaps sound to follow soon
> afterwards. And graphics cards and modems are obviously half-way there
> already. 

You left out the black helicopters... the reason vendors support Linux is
to sell product. If the driver doesn't work well some number of people
will either debug and fix the problem (source) or not buy the product
(binary). And giving out the spec and letting someone else do the driver
is even better, no work, no cost, no liability for bugs.

I think the vendors who feel that they have something to hide are the
exception, and rumor has it that fixes in Linux drivers migrate back into
Windows drivers, another fringe benefit.

> Personally, I think it's time to do some sort of trademark enforcement
> or something so that companies can't get away with slapping penguins
> on devices that only work with 2.2.14 Red Hat kernels.

On that I agree, but remember that only one Penguin has a vote on that. A
Trademark must be defended or it will be lost, maybe this would be a good
place to start. Let a lawyer advise on stuff like that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

