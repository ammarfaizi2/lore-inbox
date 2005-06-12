Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVFLJCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFLJCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 05:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVFLJCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 05:02:08 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:30159 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261226AbVFLJCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 05:02:03 -0400
Date: Sun, 12 Jun 2005 05:02:01 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050612064939.GB4897@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506120502.01752.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu>
 <200506112140.36352.gene.heskett@verizon.net> <20050612064939.GB4897@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 June 2005 02:49, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> >   * clears out immediately (and will be freed).
>> >-
>>
>> I just tried to build the V0.7.48-12 version, preempt mode 3, no
>> hardirq's, and got this:
>
>does -48-13 work any better?
>
> Ingo

Dunno, twasn't there till I looked just now.  And it made it past that 
little roadblock ok.  Gonna be slow, logrotate & updatedb are running 
as its just past 4am local.  Like any good geek, I had to check my 
email when I got up to p. :-)

Yes, it built, and I'm rebooted to it.  Feels rather normal so far. A 
quick game of klondike lagged for the first 3 or 4 moves but smoothed 
right up.

Glitch reports as they develop of course.

Q:  Whats the diff between turning on hardirq's in mode 3, and mode 4?


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
