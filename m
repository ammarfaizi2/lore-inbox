Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTBXIdy>; Mon, 24 Feb 2003 03:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTBXIdy>; Mon, 24 Feb 2003 03:33:54 -0500
Received: from holomorphy.com ([66.224.33.161]:54447 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264936AbTBXIdx>;
	Mon, 24 Feb 2003 03:33:53 -0500
Date: Mon, 24 Feb 2003 00:43:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224084305.GO10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Ben Greear <greearb@candelatech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org> <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224080052.GA4764@gnuppy.monkey.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 11:54:30PM -0800, William Lee Irwin III wrote:
>> And scalability is as essential there as it is on 512x/16TB O2K's.
>> For this, it's _downward_ scalability, where "downward" is relative to
>> "typical" UP x86 boxen.

On Mon, Feb 24, 2003 at 12:00:52AM -0800, Bill Huey wrote:
> The good thing about Linux is that, with some compile options, stuff
> (scalability) can be insert and removed and any time. One shouldn't
> narrow their view of how an OS can be out of a strict tradition.

No!! Scalability means the kernel figures out how to adapt to the box.
Removing scalability means it no longer adapts to the size of your box.
Scalability includes scaling "downward" to smaller systems.


On Mon, Feb 24, 2003 at 12:00:52AM -0800, Bill Huey wrote:
> I don't buy this spinlock-for-all-locking things tradition with no
> preemption, especially given some of the IO performance improvement
> that happened as a courtesy of preempt. Some how that was forgotten
> in Larry's discussion.

I've largely not been a party to the preempt business. Advances in
scheduling semantics are good, but are not my focus.


-- wli
