Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSEYEZe>; Sat, 25 May 2002 00:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSEYEZd>; Sat, 25 May 2002 00:25:33 -0400
Received: from bitmover.com ([192.132.92.2]:23504 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313416AbSEYEZd>;
	Sat, 25 May 2002 00:25:33 -0400
Date: Fri, 24 May 2002 21:25:33 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Karim Yaghmour <karim@opersys.com>, Andrea Arcangeli <andrea@e-mind.com>,
        Dan Kegel <dank@kegel.com>, Andrew Morton <akpm@zip.com.au>,
        Hugh Dickins <hugh@veritas.com>, Christoph Rohland <cr@sap.com>,
        Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020524212533.A22643@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Karim Yaghmour <karim@opersys.com>,
	Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
	Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
	Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CEF0911.425C00E7@opersys.com> <Pine.LNX.4.44.0205242059410.4177-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 09:08:27PM -0700, Linus Torvalds wrote:
> It all tends to boil down to a device driver in the end, and the amount of
> support you're willing to give it. Soft realtime can handle the rest.
> 
> Personally, I'm _not_ interested in making device drivers look like
> user-level. They aren't, they shouldn't be, and microkernels are just
> stupid.

Amen to that.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
