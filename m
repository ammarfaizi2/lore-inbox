Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSEYXqP>; Sat, 25 May 2002 19:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSEYXqO>; Sat, 25 May 2002 19:46:14 -0400
Received: from bitmover.com ([192.132.92.2]:30932 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315459AbSEYXqK>;
	Sat, 25 May 2002 19:46:10 -0400
Date: Sat, 25 May 2002 16:46:11 -0700
From: Larry McVoy <lm@bitmover.com>
To: Robert Schwebel <robert@schwebel.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525164611.E18274@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Robert Schwebel <robert@schwebel.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020525143333.A17889@work.bitmover.com> <20020525215547.6912411972@denx.denx.de> <20020525150542.B17889@work.bitmover.com> <20020526013735.E598@schwebel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 01:37:35AM +0200, Robert Schwebel wrote:
> You blame the RTAI developers for license violations without any proof. 

The RTAI current release COPYING says that it is LGPL, not GPL.  OK,
now go read the source.  There is absolutely *zero* doubt in my mind that
that code is derived from the RTLinux source tree.  And I'd be happy to
be called as an expert witness in court and walk the court through the
diffs, there is no way anyone would disagree.

And in spite of the RTAI guys changing lots of stuff, the source base in
which they were working was GPLed.  In order for them to change the license,
they have to prove that it was not a derived work.  Let's see, it's the
trying to solve the same problem, it started with the same source base,
you can still look at it and see that it was the same source base, and
you think they'll wiggle out of a derived work restriction?  Not a chance.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
