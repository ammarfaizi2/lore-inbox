Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSEYQOq>; Sat, 25 May 2002 12:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSEYQOp>; Sat, 25 May 2002 12:14:45 -0400
Received: from bitmover.com ([192.132.92.2]:27346 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314748AbSEYQOo>;
	Sat, 25 May 2002 12:14:44 -0400
Date: Sat, 25 May 2002 09:14:44 -0700
From: Larry McVoy <lm@bitmover.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Larry McVoy <lm@bitmover.com>, Karim Yaghmour <karim@opersys.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525091444.H28795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Thunder from the hill <thunder@ngforever.de>,
	Larry McVoy <lm@bitmover.com>, Karim Yaghmour <karim@opersys.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
	Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
	Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020524223950.D22643@work.bitmover.com> <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 01:59:10AM -0600, Thunder from the hill wrote:
> I think the point he's tryin' to make is somewhere else than that. There 
> are lots of companies running embedded devices (oh yes, I can tell ;-), 
> and as long as it is a) not clear and/or b) impossible by license to use 
> real time linux w/their licenses, they won't.
> 
> Embedded and real time devices are "The Future" for lots of companies. And 
> of course they're going to want to sell it. Currently, they have three 
> ways:
> 
> 1. They try RTAI and don't have any licensing problems, but they are very 
>    unsure about it, since certain people keep telling that RTAI is crap
> 
> 2. They get used to RTLinux, where they are altogether forced to use 
>    either GPL or their license. This isn't exactly a way of choice.
> 
> 3. They go buy another real time os implementation.

4.  Contact FSMlabs, ask about licensing costs, compare to #3 and go with
    #4 if it makes sense.

If we were hearing about lots of companies who want to use RT/Linux
and have choosen not to do so because of the licensing, there might be
cause for concern.  I'm sure there are companies who have choosen to
skip RT/Linux once they realized it wasn't free, that's too bad, but
not the end of the world.  In the long run, it's probably good because
somebody has to emerge with a business model which will allow them to
make enough money to support the RT stuff.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
