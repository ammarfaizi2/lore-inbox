Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSEYVFc>; Sat, 25 May 2002 17:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSEYVFb>; Sat, 25 May 2002 17:05:31 -0400
Received: from bitmover.com ([192.132.92.2]:41939 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315338AbSEYVFb>;
	Sat, 25 May 2002 17:05:31 -0400
Date: Sat, 25 May 2002 14:05:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Larry McVoy <lm@bitmover.com>, Karim Yaghmour <karim@opersys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525140532.A11297@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Wolfgang Denk <wd@denx.de>, Larry McVoy <lm@bitmover.com>,
	Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020525133637.B17573@work.bitmover.com> <20020525205139.D283611972@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 10:51:34PM +0200, Wolfgang Denk wrote:
> > and the guy who did that work freely admitted that it was a fork of the 
> > RT/Linux source base?
> 
> Yes, of course it was a fork at a very early point  of  the  develop-
> ment. So what? Nobody denies that RTAI is based on the same core idea
> as RT-Linux - that's why the RT-Linux patent _is_ an issue to RTAI.

s/same core idea/same core code/

Go search around, get the code you can still find on the net and start
diffing.  So not only do the RTAI people have an issue with the patent,
it looks like they'd better be conforming to the GPL as well.  Didn't
RTAI switch the copyright on "their" sourcebase to LGPL?  So explain to
me how you can take a GPLed source base, change it, and then change the
license.  Are you saying that 100% of that source base has been rewritten?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
