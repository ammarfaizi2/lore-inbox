Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSEZEDo>; Sun, 26 May 2002 00:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSEZEDn>; Sun, 26 May 2002 00:03:43 -0400
Received: from pool-129-44-55-198.ny325.east.verizon.net ([129.44.55.198]:31239
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S315630AbSEZEDm>; Sun, 26 May 2002 00:03:42 -0400
Date: Sun, 26 May 2002 00:03:37 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Larry McVoy <lm@work.bitmover.com>, Erwin Rol <erwin@muffin.org>,
        linux-kernel@vger.kernel.org, RTAI users <rtai@rtai.org>
Subject: Re: RTAI/RtLinux
Message-ID: <20020526000337.A31674@arizona.localdomain>
In-Reply-To: <1022317532.15111.155.camel@rawpower> <20020525090537.G28795@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 09:05:37AM -0700, Larry McVoy wrote:
> So the thing I have a problem with is that Victor says that all GPL
> is fine.  You say you are all GPL.  So far, no problem.  Yet you keep
> coming back and saying there is a problem, that Linux is going to
> be out of the running as a real time platform because of the patent.
> I don't get it, why should the patent prevent Linux from being used?

The problem is with a non-GPL userspace.

Using an analogy, consider what would occur if a company revealed it had a
patent on some key part of the Linux dcache - a patent free for all GPL
users, but requiring a license for any commercial code.  In theory this
isn't a problem, but what happens when that company starts demanding
licensing fees from application developers like Oracle, IBM, and even
BitKeeper Inc?  What if the patent holder was Rational Inc and they were
not eager to license the patent to some companies?  Finally consider what
would happen if there were a dozen (hundreds?) of patent owners demanding
royalties for a userspace application.

To be clear, I do not believe this is the case with RTAI.  Their userspace
appears to be distinctly different from Linux userspace.  But I hope you
can appreciate why this concept can be very disturbing.

-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
