Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbTCICet>; Sat, 8 Mar 2003 21:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262372AbTCICet>; Sat, 8 Mar 2003 21:34:49 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:775 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262370AbTCICen>; Sat, 8 Mar 2003 21:34:43 -0500
Date: Sat, 8 Mar 2003 21:41:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Michael Vergoz <mvergoz@sysdoor.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High Mem Options
In-Reply-To: <20030305140257.2ab08ab8.mvergoz@sysdoor.com>
Message-ID: <Pine.LNX.3.96.1030308213907.5356C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, Michael Vergoz wrote:

> Right, but if the pagetable pointing to a different 4GB subsets of memory.
> The performance of the system can be disastrous, not?

No. It may be measurable, but I've seen posts from very competent people
indicating that penalties of 2-5% are usual. Swapping to disk is going to
hurt a lot more than that, so if a system has lots of processes more
memory is usually better.

Maybe some of the benchmark gurus can point you to numbers on this.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

