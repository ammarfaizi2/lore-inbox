Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSEZEDa>; Sun, 26 May 2002 00:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSEZED3>; Sun, 26 May 2002 00:03:29 -0400
Received: from bitmover.com ([192.132.92.2]:19157 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315629AbSEZED2>;
	Sun, 26 May 2002 00:03:28 -0400
Date: Sat, 25 May 2002 21:03:30 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Schleef <ds@schleef.org>
Cc: Karim Yaghmour <karim@opersys.com>, Larry McVoy <lm@bitmover.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525210330.A20253@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
	Larry McVoy <lm@bitmover.com>, Wolfgang Denk <wd@denx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020525110208.A15969@work.bitmover.com> <20020525182617.D627E11972@denx.denx.de> <20020525114426.B15969@work.bitmover.com> <3CEFEB73.5BB2C14C@opersys.com> <20020525133637.B17573@work.bitmover.com> <20020525190913.A6869@stm.lbl.gov> <20020525201749.A19792@work.bitmover.com> <20020525204542.A10392@stm.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 08:45:42PM -0700, David Schleef wrote:
> > Good luck making that stick in court.  First of all, the RTAI guys have
> > admitted over and over that RTAI is a fork of the RTLinux source base.
> 
> Paolo (the maintainer) hasn't.  I (the second largest contributor)
> hasn't.  I understand why others talk about RTAI and RTLinux forking,

http://www.tux.org/pub/devel/LINUX-LAB/RTAPPS/paolo/myrtlinux-0.6.README

> I actually _do_ my research.

Me too.  I've been here before, I was one of about 8 people who actually
knew that AT&T should have won the BSD lawsuit because I diffed the code.
And you can't diff it with a perl script, that simply doesn't work.  The
only real ways that I know of are
    a) have a human do it, function by function
    b) compile the code to an expression tree and then diff the expression
       trees.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
