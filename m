Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSEYEoC>; Sat, 25 May 2002 00:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSEYEoB>; Sat, 25 May 2002 00:44:01 -0400
Received: from bitmover.com ([192.132.92.2]:28880 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313492AbSEYEoB>;
	Sat, 25 May 2002 00:44:01 -0400
Date: Fri, 24 May 2002 21:44:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020524214402.B22643@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Karim Yaghmour <karim@opersys.com>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
	Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
	Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205241440210.28644-100000@home.transmeta.com> <3CEEC729.74625C2B@opersys.com> <20020524162228.D28795@work.bitmover.com> <3CEF139A.1572367C@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 12:31:22AM -0400, Karim Yaghmour wrote:
> Exactly, so would I. Except that they haven't been very verbose. All we
> ever got from them  was "speak to your lawyer". Sure that's fair enough,
> but my entire point is: This uncertainty and lack of clarity is hurting
> Linux very badly.

Err, I'm willing to believe that this is all hurting you badly, from what
I can gather, you make your money off of RTAI.  That means you have a
beef with FSMlabs because they hold the patent on technology you need
for your revenue stream.  That's a problem for you, butI fail to see
who that turns into a problem for Linux.

> Not really. I'm saying that Linux is in deep-shit (sorry for the wording)
> because of this patent and until someone gets rid of it, other OSes will
> be chosen instead of it.

Actually, the RT that FSMlabs does works under BSD as well.  So I suspect
that part of the reason people choose other OSes is because of licensing,
not because of any fear of the patent.

> It matters little whether I look at this from the copyright perspective
> or from the patent perspective. What I'm trying to highlight is that the
> current real-time Linux patent/copyright situation is killing Linux in
> an entire application field.

Oh, come on.  Yeah, there have been lots of visible failures but my
opinion is that it is exaclty because of a lack of anything like this
patent.  You need a business model.  If you have no IP then it's 
awfully hard to sell what you don't own for more than the next guy.
The free market will drive the price down to the absolute minimum
possible, which will amount to consulting fees for enhancements and
bug fixes and that's it.  Life is hard.

> >  You can't take the GPL rules and impose that on his patent
> > license, the two have nothing to do with each other.  He who holds
> > the patent makes the rules.
> 
> Again, I agree. I don't question any of this and I perfectly understand
> the copyright/patent laws involved.

OK, that's great, then deal with the reality as it stands.  If you think
the patent is invalid, you are welcome to challenge it in court.  If you
aren't going to do that, then I fail to see how raising a stink here is
going to help you.  If anything, it's going to make more clear that you
don't own the technology on which you depend for your revenue.  Not a
good business position...
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
