Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTBXHpr>; Mon, 24 Feb 2003 02:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTBXHpr>; Mon, 24 Feb 2003 02:45:47 -0500
Received: from holomorphy.com ([66.224.33.161]:39599 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265603AbTBXHpq>;
	Mon, 24 Feb 2003 02:45:46 -0500
Date: Sun, 23 Feb 2003 23:54:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224075430.GN10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Ben Greear <greearb@candelatech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com> <20030224074447.GA4664@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224074447.GA4664@gnuppy.monkey.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 08:57:17PM -0800, Larry McVoy wrote:
>> Dig through the mail logs and you'll see that I was completely against the
>> preemption patch.  I think it is a bad idea, if you want real time, use
>> rt/linux, it solves the problem right.

On Sun, Feb 23, 2003 at 11:44:47PM -0800, Bill Huey wrote:
> And large unbounded operation on data structures. DOS, a single tasking
> operating system is fast running a single thread of execution too, it just
> happens to also be completely useless.
> Whether folks like it or not, embedded RT is the future of Linux much more
> so than any single NUMA machine that's sold or can be sold by IBM, SGI and
> any other vendor of that type.

And scalability is as essential there as it is on 512x/16TB O2K's.

For this, it's _downward_ scalability, where "downward" is relative to
"typical" UP x86 boxen.


-- wli
