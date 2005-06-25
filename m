Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263343AbVFYFlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbVFYFlT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 01:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbVFYFlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 01:41:18 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:11916 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S263343AbVFYFkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 01:40:08 -0400
Date: Sat, 25 Jun 2005 01:39:59 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050625044757.GA14979@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Message-id: <200506250139.59620.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu> <20050625044129.GA12440@elte.hu>
 <20050625044757.GA14979@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 00:47, Ingo Molnar wrote:
>* Ingo Molnar <mingo@elte.hu> wrote:
>> * Gene Heskett <gene.heskett@verizon.net> wrote:
>> > I can report that mode 4 is not at all well here.  I turned it
>> > on and changed the extraversion, built it, and when it booted,
>> > it got to this line and hung:
>> >
>> > Checking to see if this processor honours the WP bit even in
>> > supervisor mode... OK.
>>
>> ok, could you try the patch below, ontop of whatever tree hung for
>> you?
>
>also included in -V0.7.50-19 and later patches.
>
> Ingo

Gahh, and I just built -18 but amanda is running so can't reboot 
anyway.  This is my night to do a graveyard at the tv transmitter so 
it'll be the middle of the day Saturday before I get one eye open 
simultainiously again.  -19 wasn't there 3 or 4 hours ago.

Thanks, I report back when I have done it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
