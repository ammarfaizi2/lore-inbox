Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136638AbREGT1v>; Mon, 7 May 2001 15:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136639AbREGT1l>; Mon, 7 May 2001 15:27:41 -0400
Received: from bitmover.com ([207.181.251.162]:26448 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S136638AbREGT1b>;
	Mon, 7 May 2001 15:27:31 -0400
Date: Mon, 7 May 2001 12:27:30 -0700
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
Message-ID: <20010507122730.A19632@work.bitmover.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@transmeta.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org> <20010505194536.D14127@work.bitmover.com> <9d6qk6$i86$1@cesium.transmeta.com> <20010507115659.T14127@work.bitmover.com> <3AF6F11E.3A03050E@transmeta.com> <20010507121822.V14127@work.bitmover.com> <3AF6F5B8.42F803C1@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <3AF6F5B8.42F803C1@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 12:21:28PM -0700, H. Peter Anvin wrote:
> Larry McVoy wrote:
> > What does BitKeeper have to do with this conversation?
> 
> Because your original post was "yeah, Bitkeeper is a memory hog but you
> can get really cheap non-ECC RAM so just stuff your system with crappy
> RAM and be happy."  Doing so dedicates my system to running a small set
> of applications, which I am utterly uninterested in.

.. BitKeeper isn't a memory hog, the kernel is bloated.  Over 100MB of
   source last I checked.  BitKeeper is incredibly good at _NOT_ being
   a memory hog, it uses the page cache as its memory pool.  If things
   fit in the cache, they go fast, if they don't, they don't.  BitKeeper
   is just like diff in that respect.  If you think BitKeeper is a memory
   hog, then you must hate diff too.  How about netscape?  Don't run that
   either?  Give me a break.

.. It's great that you aren't interested in running that set of small 
   applications, I'm sure the entire kernel list is happy to learn that.

.. You can get really cheap ECC ram as well, even if it were 2x as expensive,
   that's still really cheap, less than 50 cents a megabyte, so what's your
   problem?  Go get some ECC memory and be happy.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
