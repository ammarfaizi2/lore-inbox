Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTBXHiC>; Mon, 24 Feb 2003 02:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTBXHiC>; Mon, 24 Feb 2003 02:38:02 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:10115 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261523AbTBXHiB>; Mon, 24 Feb 2003 02:38:01 -0500
Date: Sun, 23 Feb 2003 23:44:47 -0800
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>, Ben Greear <greearb@candelatech.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224074447.GA4664@gnuppy.monkey.org>
References: <Pine.LNX.3.96.1030223182350.999E-100000@gatekeeper.tmr.com> <33350000.1046043468@[10.10.2.4]> <20030224045717.GC4215@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224045717.GC4215@work.bitmover.com>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 08:57:17PM -0800, Larry McVoy wrote:
> Dig through the mail logs and you'll see that I was completely against the
> preemption patch.  I think it is a bad idea, if you want real time, use
> rt/linux, it solves the problem right.

And large unbounded operation on data structures. DOS, a single tasking
operating system is fast running a single thread of execution too, it just
happens to also be completely useless.

Whether folks like it or not, embedded RT is the future of Linux much more
so than any single NUMA machine that's sold or can be sold by IBM, SGI and
any other vendor of that type.

bill

