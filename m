Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314743AbSEYQFj>; Sat, 25 May 2002 12:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSEYQFi>; Sat, 25 May 2002 12:05:38 -0400
Received: from bitmover.com ([192.132.92.2]:24530 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314743AbSEYQFh>;
	Sat, 25 May 2002 12:05:37 -0400
Date: Sat, 25 May 2002 09:05:37 -0700
From: Larry McVoy <lm@bitmover.com>
To: Erwin Rol <erwin@muffin.org>
Cc: linux-kernel@vger.kernel.org, RTAI users <rtai@rtai.org>
Subject: Re: RTAI/RtLinux
Message-ID: <20020525090537.G28795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Erwin Rol <erwin@muffin.org>, linux-kernel@vger.kernel.org,
	RTAI users <rtai@rtai.org>
In-Reply-To: <1022317532.15111.155.camel@rawpower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 11:05:32AM +0200, Erwin Rol wrote:
> Both Linus and Larry seem to be not very interested in hard-realtime
> Linux additions, this is OK. 

I'm interested in hard realtime.  I'm extremely uninterested in changes 
to the mainline source base in order to get them.  That's exactly why
I like the RT/Linux approach so much, it is the least invasive to the
kernel and - surprise - also has the best performance.

If people were to learn that real time and multi-user throughput are 
by definition mutually exclusive, I'd be a lot happier.  As it is,
we have the SGI/Montevista crowd cramming their stuff into the kernel
and each "little" thing makes the kernel a less pleasant place to be
and brings it one step closer to the point when it gets abandoned 
like ever other OS in the history of our field.

> Also apparently there is the idea that all RTAI developers want to
> become rich by getting the patent out of the way and sell RTAI. 

So the thing I have a problem with is that Victor says that all GPL
is fine.  You say you are all GPL.  So far, no problem.  Yet you keep
coming back and saying there is a problem, that Linux is going to
be out of the running as a real time platform because of the patent.
I don't get it, why should the patent prevent Linux from being used?
All it does is say "if you aren't making money, we aren't making money,
if you are making money, we want a cut".  That seems OK to me, in fact,
it seems more than OK.  It seems like someone who is trying to help
those who are helping others and charge those who are charging others.
That's smart, that's good.  It means that FSMlabs will be here 20 years
from now, still supporting this stuff, whereas all the "we'll survive
off of support" people will have long since gone under.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
