Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262131AbSJIXtW>; Wed, 9 Oct 2002 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262105AbSJIXtW>; Wed, 9 Oct 2002 19:49:22 -0400
Received: from bitmover.com ([192.132.92.2]:27320 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262312AbSJIXtU>;
	Wed, 9 Oct 2002 19:49:20 -0400
Date: Wed, 9 Oct 2002 16:55:00 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK is *evil* corporate software [was Re: New BK License Problem?]
Message-ID: <20021009165500.L27050@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <20021005112552.A9032@work.bitmover.com> <20021007001137.A6352@elf.ucw.cz> <5.1.0.14.2.20021007204830.00b8b460@pop.gmx.net> <20021007143134.V14596@work.bitmover.com> <ao2ee1$l0c$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ao2ee1$l0c$1@forge.intermeta.de>; from hps@intermeta.de on Wed, Oct 09, 2002 at 11:34:25PM +0000
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's insert some fact in this discussion:

OK.

> Basically you charge a small(-ish) company about $25k for any
> reasonable license. This is about as much as we spent for Software in
> the last seven years (we do own a few Windows and Office licenses).
> 
> bk might be interesting for larger companies with software budgets in
> the six figure range and for open source. For the vast number of three
> to five developers enterprises, it's simply unreasonably priced. For
> 25k$ I get about six man months from a really good developer to work
> on <insert your SCM here>.

Sure.  And if you have 3-5 developers there is no reason to not use CVS,
it works well enough.  Or Subversion after it matures, or Arch, or Aegis,
or tarballs+diff+patch.  

We can't, and won't, compete at that level.  You're comparing free against
what we charge.  We're infinitely expensive in that comparison.

OK, now let's look at it as you grow.  Most of our customers are in the 
25-100 developer range.  They move very quickly and have lots of parallelism
in the code.  So things like work flow and merging are critical, if that
doesn't work, the whole team slows down.  Let's say we have a 60 seat sale.
That's $90K/year for BK.  Let's say the engineers cost $100K/each (it
may be lower where you are but it's more like $180-220 here when you add
in building/mgmt/all the other overhead).  So that's $6M/year in engineers.
The BK cost is 1.5% of that.  You say that your guys are $50K/year?  OK,
so we're at 3% of that.  The point is that if BK makes your team 3% more
productive, it costs zero.

And none of that includes the hardware costs, which are dramatically
cheaper for BK, it works on a laptop.  Clearcase doesn't.

Whatever, I know that BK doesn't make sense for a 3 man shop.  And I
know you think it is way too expensive.  Your opinion is not universally
shared because the costs start to make more and more sense as you get
larger.  I am sorry if you don't agree but that's the way it is.  You
are welcome to use Perforce or CVS instead, we encourage it in fact.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
