Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSBNACr>; Wed, 13 Feb 2002 19:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289198AbSBNAC1>; Wed, 13 Feb 2002 19:02:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61191 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289191AbSBNACS>; Wed, 13 Feb 2002 19:02:18 -0500
Date: Wed, 13 Feb 2002 19:01:12 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Allan Sandfeld <linux@sneulv.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-rc1
In-Reply-To: <E16b8HV-0001JS-00@Princess>
Message-ID: <Pine.LNX.3.96.1020213185125.13096B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Allan Sandfeld wrote:

> On Wednesday 13 February 2002 20:33, Marcelo Tosatti wrote:
 
> Here's a crazy idea. Why not branch off the new pre-tree when commiting a 
> rc-kernel? 

I agree with everything you said, but I think it would be a lot more work
to have more than one going at once, plus the -ac branch is already in
some sense the best of the pre stuff, in that it has most of the good
features and still is usefully reliable. Alan is the hero here.

That said, the only way I can see which might even possibly make this
happen would be for another person to take over when the transition from
pre to rc was made, so that they could do the work. I think the logistics
are against it.

The final problem is that fewer people would actually try it, and that's a
seriously bad thing. The whole idea of -rc was to stop adding new things
and get people to really use the kernel. Another pre version would detract
from the 2nd half of that.

    [ I finally just snipped your arguments, I agree with every one ]

But I still think the world will be a better place if the -rc gets more
use.

I have use a lot of -ac stuff in the past, but right now I'm trying to get
rmap, O(1) and ll to play reliably. I think the -aa stuff is a bit faster
on big machines, but rmail12e+K3 is just so responsive on small machines
that I am going that way until the performance of the stock kernel picks
up (meaning all the stuff I want to use gets merged by someone like Alan).

This is one of those bad great ideas, all positives and one big negative.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

