Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262870AbSJGFXR>; Mon, 7 Oct 2002 01:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSJGFXR>; Mon, 7 Oct 2002 01:23:17 -0400
Received: from otter.mbay.net ([206.55.237.2]:55814 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S262870AbSJGFXP> convert rfc822-to-8bit;
	Mon, 7 Oct 2002 01:23:15 -0400
From: John Alvord <jalvo@mbay.net>
To: Rob Landley <landley@trommello.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Sun, 06 Oct 2002 22:28:40 -0700
Message-ID: <qj62qusehhp7nsvmm6kru60fpu5gacqn6l@4ax.com>
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
In-Reply-To: <200210060130.g961UjY2206214@pimout2-ext.prodigy.net>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002 16:30:32 -0400, Rob Landley <landley@trommello.org>
wrote:

>On Friday 04 October 2002 07:13 pm, Linus Torvalds wrote:
>> On Fri, 4 Oct 2002, Martin J. Bligh wrote:
>> > When you say we have "some of" that (NuMA support) ... what else would
>> > you like to see?
>>
>> The main thing that I think is lacking is any relevance to any significant
>> user base, thanks to lack of interesting hardware. So even if Linux itself
>> was doing everything perfectly, as long as there is no wide hw base and
>> users, it's all pretty much academic, the same way SMP was during the
>> early 1.x days.
>>
>> And I'm not trying to put you or any of the Linux NuMA work down here, I'm
>> just saying that what makes it not important as a "3.0 feature" is just
>> that deployment doesn't merit it yet.
>
>Linux isn't going to get  a new order of magnitude surge from the server 
>space, because there isn't an order of magnitude left.  The figures I've seen 
>from several sources broadly agree that Linux currently has somewhere between 
>a fifth and a third of the server market, has been doing quite well on that 
>score for some time, and continues to make steady incremental advances 
>(taking about equal amounts of market share away from proprietary unixen and 
>NT boxen).  2.4 is already pretty darn good on a server (assuming you never 
>hit swap. :).  Even 2.2 wasn't at all bad at it.
>
>The new uncharted territory for Linux, and the next major order-of-magnitude 
>jump in the installed base, is the desktop.  A kernel that could make a 
>credible stab at the desktop  would certainly be 3.0 material.  And the work 
>that matters for the desktop  is LATENCY work.  Not SMP, not throughput, not 
>more memory.  Latency.  O(1), deadline I/O scheduler, rmap, preempt, shorter 
>clock ticks, 

The big drag on making progress on the desktop is the inertia of
existing applications. Speed/Performance is rarely a problem... just
wait a few months for more power or lower price. PCs are already
overpowered for the typical desktop workload.

Progress in that area is always possible but it will be very slow and
marginal.

john alvord
