Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315695AbSEZETA>; Sun, 26 May 2002 00:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315711AbSEZES7>; Sun, 26 May 2002 00:18:59 -0400
Received: from bitmover.com ([192.132.92.2]:28373 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315695AbSEZES4>;
	Sun, 26 May 2002 00:18:56 -0400
Date: Sat, 25 May 2002 21:18:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: Erwin Rol <erwin@muffin.org>, linux-kernel@vger.kernel.org,
        RTAI users <rtai@rtai.org>
Subject: Re: RTAI/RtLinux
Message-ID: <20020525211857.C20253@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kevin O'Connor <kevin@koconnor.net>, Erwin Rol <erwin@muffin.org>,
	linux-kernel@vger.kernel.org, RTAI users <rtai@rtai.org>
In-Reply-To: <1022317532.15111.155.camel@rawpower> <20020525090537.G28795@work.bitmover.com> <20020526000337.A31674@arizona.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 12:03:37AM -0400, Kevin O'Connor wrote:
> Using an analogy, consider what would occur if a company revealed it had a
> patent on some key part of the Linux dcache - a patent free for all GPL
> users, but requiring a license for any commercial code.  In theory this
> isn't a problem, but what happens when that company starts demanding
> licensing fees from application developers like Oracle, IBM, and even
> BitKeeper Inc?  What if the patent holder was Rational Inc and they were
> not eager to license the patent to some companies?  

If you think that we don't worry about this, you're wrong.  That's why we
write our own code here and don't depend on outside code, and it's also
why we are constantly spending time in the patent database.  We've made
changes to BK to avoid Rational patents.  Actually, that may not be true,
I just assumed that Rational had the merge alg they use patented but I
never actually found a patent for it.  No worries, we came up with a 
much nicer way to do it that I'm positive they do not have patented
because their system can't do it.

And that's what the RTAI guys or anyone else would have to do as well.
That's why real engineering is so expensive, it's not enough to just
build it, you have to build it in a way that hasn't been covered by
some patent.  The only real way I know to do that cheaply is to be
ahead of everyone else.  Otherwise you have to do your homework.  And 
at this point, it's virtually impossible to be ahead of everyone else,
too much ground has been covered.  So you watch the patent database,
you think about how other people solve the problems, you do what you
can.  It's not pleasant.  That's way they pay you to do it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
