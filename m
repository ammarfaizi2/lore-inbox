Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbTIXCbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 22:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTIXCbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 22:31:12 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:33925 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261219AbTIXCbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 22:31:10 -0400
Date: Tue, 23 Sep 2003 19:29:48 -0700
From: Larry McVoy <lm@bitmover.com>
To: andrea@kernel.org
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924022948.GA6496@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, andrea@kernel.org,
	Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
References: <20030923221528.GP1269@velociraptor.random> <Pine.LNX.4.44.0309231524160.24527-100000@home.osdl.org> <20030924003652.GI16314@velociraptor.random> <20030924011951.GA5615@work.bitmover.com> <20030924020409.GL16314@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924020409.GL16314@velociraptor.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 04:04:09AM +0200, andrea@kernel.org wrote:
> > What we expected in return was the same understanding.
> 
> that is not accurate, you also asked us to giveup the freedom of
> development in your area. 

If you were actually doing some significant development then maybe I'd
respect you.  But you aren't.  So I don't.  You don't have the slightest
understanding in this area, you've proved that beyond all reasonable
doubt.  So you are just complaining about something you don't understand.

I truly hope you follow in the footsteps of others who got pissed at the
BK licensing and try to implement a replacement.  BK makes VM systems
seem like child's play.  Centralized systems like CVS are child's play.
Distributed systems like BK actually have to address all the problems
that CVS ignores.  Those problems are really hard.  Not because they are
so hard (even though they are), but because there are so many of them.

It may be an eye opener to you if you realized that most of the problems
that the researchers are discussing about distributed file systems, those
are problems that we have solved.  Computer science research is behind us.
No kidding.  Go get your best and bring 'em on, we'll take the challenge.
There are at least a dozen excellent PhD theses in BK.  And those are the
ones I can think of at the end of a very long tiring day.

If you understood that you'd understand why I am so unhappy with you.
We've bent over backwards to give you what you need and you still don't
understand what we have given you.  You think it is something that you
can fix in a few days of hacking.

I'm reminded of something Peter Gutmann said recently:

    Whenever someone thinks that they can replace SSL/SSH with something
    much better that they designed this morning over coffee, their
    computer speakers should generate some sort of penis-shaped sound
    wave and plunge it repeatedly into their skulls until they achieve
    enlightenment.

Change "SSL/SSH" to "useful source mangement" and it makes the point.
I hope your skull hurts.  It should.  Enlightenment is then forthcoming.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
