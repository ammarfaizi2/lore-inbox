Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263048AbVF3WRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbVF3WRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVF3WRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:17:54 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:21495 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S263048AbVF3WRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:17:38 -0400
Date: Thu, 30 Jun 2005 18:17:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-37
In-reply-to: <20050630204826.GA2114@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, William Weston <weston@sysex.net>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Message-id: <200506301817.36824.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <20050630195258.GB20310@elte.hu> <20050630204826.GA2114@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 16:48, Ingo Molnar wrote:
>* Ingo Molnar <mingo@elte.hu> wrote:
>> * William Weston <weston@sysex.net> wrote:
>> > Hi Ingo,
>> >
>> > -50-37 wouldn't compile out of the box on my debug config.
>> > Here's a couple minor cleanups:
>>
>> thanks, applied. [...]
>
>i've uploaded -39 with your fixes and other fixes - could you check
> that it compiles cleanly for you now?
>
> Ingo

I'll go try this one after dinner, we been w/o power here for about 3 
hours.  The only machine that rebooted ok was the one NOT on a ups, 
but running the LVM (FC4 box).  Interesting.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
