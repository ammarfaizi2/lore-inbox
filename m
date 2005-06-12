Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVFLOXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVFLOXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 10:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVFLOXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 10:23:38 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:18848 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261666AbVFLOXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 10:23:36 -0400
Date: Sun, 12 Jun 2005 10:23:23 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050612134907.GA17467@elte.hu>
To: linux-kernel@vger.kernel.org
Message-id: <200506121023.23862.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu>
 <200506120940.11698.gene.heskett@verizon.net> <20050612134907.GA17467@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 June 2005 09:49, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> I think I see.  Do you have a swag as to how much runtime overhead
>> using softirq's only might cause? [...]
>
>should be barely measurable for desktop workloads. For servers it
> might be significant, depending on the amount of IRQ traffic. For
> any box doing less than 2000-3000 irqs/sec it should be very small.
>
> Ingo

Chuckle, for me that would be a 'mox nix' using the english 
spelling. :-)  And seti made a liar out of me, it did do 7 units 
yesterday.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
