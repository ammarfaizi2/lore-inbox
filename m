Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSEYUvq>; Sat, 25 May 2002 16:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSEYUvp>; Sat, 25 May 2002 16:51:45 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:22492 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315337AbSEYUvp>; Sat, 25 May 2002 16:51:45 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)] 
X-Mailer: exmh version 2.2
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: Your message of "Sat, 25 May 2002 13:36:37 PDT."
             <20020525133637.B17573@work.bitmover.com> 
Date: Sat, 25 May 2002 22:51:34 +0200
Message-Id: <20020525205139.D283611972@denx.denx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020525133637.B17573@work.bitmover.com> Larry McVoy wrote:
>
> A couple of points.  If you are going to rewrite, then you should rewrite.
> I'm told, and I've seen, that there substantial parts of RT/Linux in the
> RTAI source base.  Isn't it true that RTAI used to be called "my-rtai"

You have seen what? Did you really compare RTAI  and  RT-Linux  code?
Which   "substantial   parts"   are  you  talking  about?  Please  be
specific!!!

> and the guy who did that work freely admitted that it was a fork of the 
> RT/Linux source base?

Yes, of course it was a fork at a very early point  of  the  develop-
ment. So what? Nobody denies that RTAI is based on the same core idea
as RT-Linux - that's why the RT-Linux patent _is_ an issue to RTAI.

On the other hand, a lot of significant features originaten in  RTAI,
and have been implemented in RT-Linux later - floating point support,
to name just one.

> want to support it, and will do so if it is really free.  On the other
> hand, as soon as money enters the equation, the rules will change and
> you're just going to have to deal with that.

Too true.

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In a business, marketroids, salespukes, and  lawyers  have  different
goals from those who actually do work and produce something. Usually,
is  is the former who triumph over the latter, due to the simple rule
that those who print the money make the rules.
         -- Tom Christiansen in <5jdcls$b04$2@csnews.cs.colorado.edu>
