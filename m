Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbTIXBUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 21:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbTIXBUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 21:20:06 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:20354 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261237AbTIXBUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 21:20:02 -0400
Date: Tue, 23 Sep 2003 18:19:51 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030924011951.GA5615@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@debian.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Larry McVoy <lm@bitmover.com>
References: <20030923221528.GP1269@velociraptor.random> <Pine.LNX.4.44.0309231524160.24527-100000@home.osdl.org> <20030924003652.GI16314@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924003652.GI16314@velociraptor.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 02:36:52AM +0200, Andrea Arcangeli wrote:
> You're right I should provide new code, and avoid comments on the a bit
> inferior info in bkcvs (that Larry nicely offered to even improve after
> cvs gets properly fixed), but I had no real interest in this area todate
> and my job keeps most of my time full already and that's higher
> priority.

The problem I have is as follows:

a) I understand your point of view and from the very first version of BK 
   we released we addressed it.  100% of the data and the metadata is 
   available from the command line with BK.  Always has been and always 
   will be, if that's not true that is is a bug and we'll fix it.  People
   use BK because they like it, not because we locked them in.

b) I understand your need to not be dependent on BitMover or BitKeeper. 
   That's why we built the CVS gateway, so you wouldn't need to depend
   on us, the data you care about is available in a form that doesn't
   require any license agreements.

What the above two points demonstrate, dramatically so, is that we
understand your concerns and agree with them.  We have spent a lot of
time and money to make sure that you are happy.  Not whining, not 
flaming, we were writing code to make you happy.  We were writing that
code long before you ever heard of BitKeeper and we have the revision
history to prove it.

What we expected in return was the same understanding.

What we got was you complaining about us, in public, over and over.

Andrea, you need to grow up and learn that biting the hand that is held
out to you and is helping you, that's not smart.  What you have done
is to make all the people who tried so hard to help you dislike you.
That is your problem.  You need to grow up.  The world is based on
relationships, people helping each other.  That means you help those
who help you, or at least don't piss all over those who help you.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
