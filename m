Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTLOQCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTLOQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:02:50 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:32695 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263778AbTLOQCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:02:48 -0500
Date: Mon, 15 Dec 2003 08:02:46 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031215160246.GA3947@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tupshin Harper <tupshin@tupshin.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20031214172156.GA16554@work.bitmover.com> <3FDCEF70.5040808@tupshin.com> <20031214234348.GA15850@work.bitmover.com> <3FDCFE17.5010309@tupshin.com> <20031215034627.GB16554@work.bitmover.com> <3FDD4FB2.8020607@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDD4FB2.8020607@tupshin.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 10:07:46PM -0800, Tupshin Harper wrote:
> > Great, glad you understand that you are crossing the legal line.
> 
> ??? what line am I crossing? Or do you mean that I would be if I were
> to do something, and if so, what is that something? I informed you the
> day that  decided I was interested in exploring the internals of other
> SCM products, and deleted the bk binaries from my machine at the same
> time.

Tupshin, the BK license makes it clear that BK doesn't want to be reverse
engineered, we've been over this and over this.  Furthermore, reverse
engineering for interoperability has a prerequisite that there is no other
way to get at the data and we give you tons of ways to get at the data.

You keep wanting more and more information about how BitKeeper manages
to do what it does and that certainly falls under reverse engineering.
Getting at the raw information is just another way to figure out how
BitKeeper manages that data, it's exactly the same as running a compiler
and looking at the assembly language it produces.  You are annoyed that
we aren't giving you the data in the format you want with a roadmap that
says here is how we did it.

I wish you'd just drop it, this isn't the place to have this discussion,
every time we do anything to help the people who are actually doing kernel
development you or someone like you feels obligated to whine about BK one
more time because of your personal agenda which has nothing to do with 
kernel development.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
