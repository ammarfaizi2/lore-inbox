Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUJ1Wum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUJ1Wum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbUJ1Wr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:47:56 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:27278 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263027AbUJ1Wpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:45:53 -0400
Date: Thu, 28 Oct 2004 15:45:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041028224534.GB29335@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com> <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com> <Pine.LNX.4.61.0410272214580.877@scrub.home> <20041028005412.GA8065@work.bitmover.com> <Pine.LNX.4.61.0410280314490.877@scrub.home> <20041028030939.GA11308@work.bitmover.com> <Pine.LNX.4.61.0410281120150.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410281120150.877@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 11:03:42PM +0200, Roman Zippel wrote:
> [complaints about the awful horrible evil BK2CVS tool]

You guys work in patches all the time.  Complaining about this loss
information is like whining at Andrew because he removes some patches
from the -mm tree.  There is no record of all the combinations of the
-mm tree and you aren't whining at Andrew?  Why not?

There is no record of all sorts of patch combinations out there and you
aren't complaining about it.  Why not?

I can tell you why not.  Because the combination and recombination of
those patches doesn't give you any insight into how BK works.

If you don't like the situation, you are welcome to go create a better 
system.  You do not get to use BK to do so, those are our rules.  You
do not get to use BK metadata to do so either, those are also our rules.

Believe it or not, I understand your frustration and can understand
how pissed off this makes you.  It's pretty frustrating on all sides.
But it's not unreasonable.  It is a reasonable thing to protect our
work, just as it is reasonable for you to protect your work against
GPL violators.

We're being reasonable, you are just frustrated that it's reasonable for
us to protect what we built and what we own.

I understand your position, you want the kernel to be a showcase for
how well free software works.  It should be developed, managed, enhanced
with 100% free software, at least in your mind.  A fine goal, and one
you could realize.  

However, one of my claims over the years is that a lot of free software
is a reimplementation of some closed software.  I've also claimed that it
is much easier to do that if you have access to the closed software, the
closed software becomes a very good specification of what should be done.
When I've claimed this lots of you get pissed off and say it's not true,
free software innovates, etc.  Sure it does, but my statement stands.
The fact that you are working so hard to get your fingers on things that
we figured out is an excellent example of the point.  If it were easy
for you to create a BK clone you would have done so already and thumbed
your nose at me.

Every time you come back and complain that you aren't getting enough 
information from us you are making my case.  Free software, at least
some of it, is no more than a copy.

It's my claim that I value free software even *more* than you do.  Why?
Because I keep trying to draw attention to this problem, the problem
of how do we pay for the development truly innovative free software.
You are hurting the cause of free software by making a public spectacle
of yourself by asking over and over again for help from a commercial
company to copy that commercial companies' software.

If you truly believed in the cause you would go off and try and build
a real BK replacement using free software tools, using only freely
available knowledge, and using funding generated from free software.
That would be the best way to prove to the world that I'm just wrong.
I would welcome that.  I'd come work with you if you figured out how
to do that.  If you think I enjoy arguing with the people I'm trying 
to help you're mistaken.  This is no more fun for me than it is for you.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
