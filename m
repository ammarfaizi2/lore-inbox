Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbUJYQYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUJYQYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUJYQYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:24:44 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:2774 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262052AbUJYQUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:20:33 -0400
Date: Mon, 25 Oct 2004 09:20:22 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041025162022.GA27979@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>, akpm@osdl.org
References: <4d8e3fd3041019145469f03527@mail.gmail.com> <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org> <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025133951.GW14325@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 03:39:51PM +0200, Andrea Arcangeli wrote:
> On Mon, Oct 25, 2004 at 05:29:02AM -0700, Joe Perches wrote:
> > 1. BK has improved LK workflow
> [..]
> > If your answer does not include 1, why?
> 
> as a matter of fact nobody can know how the workflow would be if _all_
> kernel developers would have been able to take advantage of a
> distributed revision control system in the last ~3 years. The simple
> fact I try to avoid discussing this topic on public lists to avoid be
> targeted as whiner as usual, doesn't mean Larry can speak for myself
> saying the few people like me now changed their mind and they agrees BK
> generally helps the workflow.

That's strange, I wonder why you think BK doesn't help.  The prevailing
wisdom is that it has helped.  It's well documented by third parties
who have nothing to do with you or me.

Is it possible that you have an axe to grind about BK and that any
positive statement about BK will be challenged by you no matter how
silly that makes you appear?

Maybe you know about some different system that would have worked better.
Perhaps you could share with the rest of us what that system is and how
it works better. 

> > From my view, LK workflow post patch penguin (ie: BK)
> > is improved simply because fewer patches seem to be lost.
> 
> IMHO that's largerly thanks to Andrew, and he's not using BK but quilt
> to manage -mm, and as far as I can see his merges with Linus are using
> patches. Infact I'm only sending my seldom patches to Andrew.

The implication that Andrew doesn't use BK is incorrect, we see him in
the logs all the time.  You're right that he uses other tools to manage
his collection of patches and we agree with his reasons for doing so.
But he also uses BK and has pointed out himself the fact that BK has
helped the kernel development effort.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
