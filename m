Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131671AbQLNKAv>; Thu, 14 Dec 2000 05:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131749AbQLNKAm>; Thu, 14 Dec 2000 05:00:42 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:44848
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S131671AbQLNKAc>; Thu, 14 Dec 2000 05:00:32 -0500
Date: Thu, 14 Dec 2000 01:30:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: josef höök <josef.hook@arrowhead.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001214013005.B6380@work.bitmover.com>
Mail-Followup-To: josef höök <josef.hook@arrowhead.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012132133190.24718-100000@www.nondot.org> <3A389183.41AEB0B4@arrowhead.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <3A389183.41AEB0B4@arrowhead.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 10:23:15AM +0100, josef höök wrote:
> Plan9 aint unix/posix though it has its Ape environment.
> What we do need to look at is a good implementation for distributed resources.
> The ideal would bee getting 9P and IL into linux. Think of having thousand of small
> 
> linux boxes dedicated to either run as a CPU server or a Fileserver or whatever
> service there is.

In the who cares department: this idea was one of the main reasons I founded
BitMover, it's what we wanted to do before we got sidetracked by BitKeeper.

So you have my vote, and if anyone does this, I'll be pissed as hell because
I wanted to do it, but happy that it's getting done.  If you look at lmbench,
it's basically designed to measure all the crud that you would need to make
this sort of thing go fast.  So I've been thinking about this for at least
6 years.  Sigh.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
