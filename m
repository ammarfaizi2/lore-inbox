Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271418AbUJVQsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271418AbUJVQsD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271425AbUJVQsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:48:03 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:961 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S271418AbUJVQsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:48:00 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10
Date: Fri, 22 Oct 2004 12:47:58 -0400
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
References: <20041014143131.GA20258@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
In-Reply-To: <20041022155048.GA16240@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410221247.58755.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.58.180] at Fri, 22 Oct 2004 11:47:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 11:50, Ingo Molnar wrote:
>i have released the -U10 Real-Time Preemption patch, which can be
>downloaded from:
>
>  http://redhat.com/~mingo/realtime-preempt/
>
>this is purely a rebasing of -U9.3 to 2.6.9-mm1.
>
>to create a -U10 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
> +
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.
>6.9-mm1/2.6.9-mm1.bz2 +
> http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm
>1-U10
>
> Ingo

As sort of the ultimate dummy test, I'm building this right now.  The 
only oddments so far are a bunch of deprecated variable warnings, 
quite a few but many are dups.

I'll repost after I've tried it.

>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
