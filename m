Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314289AbSDVRSj>; Mon, 22 Apr 2002 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314290AbSDVRSf>; Mon, 22 Apr 2002 13:18:35 -0400
Received: from bitmover.com ([192.132.92.2]:3751 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314289AbSDVRRv>;
	Mon, 22 Apr 2002 13:17:51 -0400
Date: Mon, 22 Apr 2002 10:17:50 -0700
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020422101750.D17613@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204202108410.10137-100000@home.transmeta.com> <E16zJbd-0001GZ-00@starship> <20020422091012.C17613@work.bitmover.com> <E16zK5f-0001He-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 06:21:27PM +0200, Daniel Phillips wrote:
> > It's not my call to make.
> 
> I know that.  I was wondering if *you personally* would have any objection.

Daniel, I won't be nagged into supporting your point of view, sorry.
I didn't even know that the doc was in the tree until you raised the
point.  I don't see a problem with it being in the tree and I do *not*
support your attempts to remove it.

You seem to think it has some great value to BitMover to have it in
the tree.  Sorry, that's not true.  It's true to some small extent, in
that it may reduce the number of support queries that we get related to
the kernel.  So we'd prefer it stayed in the tree.

Why don't you ask Jeff to stick in the doc saying something like

    BitKeeper is not free software.  You may use it for free, subject
    to the licensing rules (bk help bkl will display them), but it is
    not open source.  If you feel strongly about 100% free software
    tool chain, then don't use BitKeeper.  Linus has repeatedly stated
    that he will continue to accept and produce traditional "diff -Nur"
    style patches.  It is explicitly not a requirement that you use
    BitKeeper to do kernel development, people may choose whatever tool
    works best for them.

> > Take it up with the people who own the tree.
> 
> That's all of us, last I heard.  Administrating it is, of course, another story.

You are, as has been repeatedly pointed out, able to create your own tree,
with your own rules, and see if you develop a following.  It's way past time
that you do so, it should be crystal clear to anyone with a clue that you
are not the administrator of this tree.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
