Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSEYVdc>; Sat, 25 May 2002 17:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSEYVdc>; Sat, 25 May 2002 17:33:32 -0400
Received: from bitmover.com ([192.132.92.2]:51155 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315413AbSEYVdb>;
	Sat, 25 May 2002 17:33:31 -0400
Date: Sat, 25 May 2002 14:33:33 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525143333.A17889@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Linus Torvalds <torvalds@transmeta.com>, Wolfgang Denk <wd@denx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205251057370.6515-100000@home.transmeta.com> <200205252122.g4PLMh290935@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 05:22:43PM -0400, Albert D. Cahalan wrote:
> To get a free patent license, EVERYTHING must be GPL.
> Not just the real-time part! So that would be:
> 
> 1. the RT microkernel (OK)
> 2. the RT "app"       (OK)
> 3. Linux itself       (OK)
> 4. normal Linux apps  (ouch!)

Whether that is true or not I don't know.  But I do know that if all the
stuff was GPLed, then you are safe no matter what, right?  In other words,
there is a path you can take which makes it safe.  And according to all the
RTAI people, that path should be completely acceptable, they all are quick
to tell you that everything they do (now) is GPLed and that's how they want
it.  If that's true, no worries.  I suspect the reality is that some/most
of the code is GPLed but there is some critical chunk that is not GPLed 
and you don't get source and that's the revenue stream.  If I'm wrong, the
RTAI folks have nothing to worry about.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
