Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTBXVBN>; Mon, 24 Feb 2003 16:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbTBXVBN>; Mon, 24 Feb 2003 16:01:13 -0500
Received: from [195.223.140.107] ([195.223.140.107]:35462 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267528AbTBXVBM>;
	Mon, 24 Feb 2003 16:01:12 -0500
Date: Mon, 24 Feb 2003 22:10:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Andrew Morton <akpm@digeo.com>, wli@holomorphy.com, lm@work.bitmover.com,
       mbligh@aracnet.com, davidsen@tmr.com, greearb@candelatech.com,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224211055.GW29467@dualathlon.random>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org> <20030224004005.5e46758d.akpm@digeo.com> <20030224085617.GA6483@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224085617.GA6483@gnuppy.monkey.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 12:56:17AM -0800, Bill Huey wrote:
> On Mon, Feb 24, 2003 at 12:40:05AM -0800, Andrew Morton wrote:
> > There is no evidence for any such thing.  Nor has any plausible
> > theory been put forward as to why such an improvement should occur.
> 
> I find what you're saying a rather unbelievable given some of the
> benchmarks I saw when the preempt patch started to floating around.
> 
> If you search linuxdevices.com for articles on preempt, you'll see a
> claim about IO performance improvements with the patch. If somethings
> changed then I'd like to know.
> 
> The numbers are here:
> 	http://kpreempt.sourceforge.net/

most kernels out there are buggy w/o preempt. 2.4.21pre4aa3 has most of
the needed preemption checks in the kernel loops instead. It's quite
pointless to compare preempt with an otherwise buggy kernel.

Andrea
