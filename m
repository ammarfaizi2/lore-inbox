Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbUJYRRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUJYRRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUJYRRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:17:08 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:58839 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261166AbUJYRNs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:13:48 -0400
Date: Mon, 25 Oct 2004 10:12:23 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041025171223.GA4503@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>, akpm@osdl.org
References: <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025164732.GE14325@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:47:32PM +0200, Andrea Arcangeli wrote:
> On Mon, Oct 25, 2004 at 09:20:22AM -0700, Larry McVoy wrote:
> > The implication that Andrew doesn't use BK is incorrect, we see him in
> > the logs all the time. [..]
> 
> I assume this is great news for bitmover: one more tainted open source
> developer that will not be allowed by law to ever compete with your
> business, right? Anyways this is offtopic for l-k, but you can still
> celebrate elsewhere.

You have made this point hundreds of times, everyone knows your position
that we're screwing over the open source world by preventing them from
copying our work.  OK, I can see that you think that, we respectfully
disagree because we feel we have to protect our IP.  Rightly or wrongly,
we feel we did some new work that is worth protecting.

The big flaw in your position is that you are not tainted, you are a good
programmer, you claim to care deeply about this issue, so you could go
solve the problem.  Either by fixing arch or creating your own system.
You should be the poster child for why the BitKeeper license is a
flawed idea.  

We both think we care about helping the kernel.  You think that we're
screwing over a pile of people who could write a GPLed SCM system.
We think that that is not true and you yourself prove our point.  Kernel
guys like working on the kernel.  If they liked working on SCM they would
be doing that, there would be a GPLed answer that was better than BK or at
least good enough, and we wouldn't be arguing, we'd probably be friends.

So who cares more about the kernel development process?  The guy who took
crap from you and your friends for years but cared enough to keep going
because what counted were _results_, or the guy who sits around and whines
that we are polluting the well which was already dry?
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
