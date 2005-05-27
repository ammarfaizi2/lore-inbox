Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVE0MtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVE0MtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVE0MtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:49:09 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:9656 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S262454AbVE0Ms7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:48:59 -0400
Date: Fri, 27 May 2005 08:48:58 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-10
In-reply-to: <20050527072810.GA7899@elte.hu>
To: linux-kernel@vger.kernel.org
Message-id: <200505270848.58563.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050527072810.GA7899@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 03:28, Ingo Molnar wrote:
>i have released the -V0.7.47-10 Real-Time Preemption patch, which
> can be downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
>Changes:
>
> - posix-timer fixes (George Anzinger )
>
> - RPC timers fix (John Cooper)
>
> - x64 build fix (Will Dyson)
>
>to build a -V0.7.47-10 tree, the following patches have to be
> applied:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>  
> http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc5.bz
>2
> http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-r
>c5-V0.7.47-10
>
> Ingo

Since plain 2.6.12-rc5 will not build here, IPMI problems, does this 
include the IPMI patches that will let it build here?

Or is this fix now included in the 2 snapshots with the .git suffix I 
see there in the 2.6/snapshots directory and I should apply them 
prior to the RT patch?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
