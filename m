Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318730AbSIPCzJ>; Sun, 15 Sep 2002 22:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSIPCzJ>; Sun, 15 Sep 2002 22:55:09 -0400
Received: from bitmover.com ([192.132.92.2]:60080 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S318730AbSIPCzI>;
	Sun, 15 Sep 2002 22:55:08 -0400
Date: Sun, 15 Sep 2002 20:00:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <landley@trommello.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Daniel Phillips <phillips@arcor.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915200002.B23345@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rob Landley <landley@trommello.org>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Daniel Phillips <phillips@arcor.de>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com> <200209160236.g8G2a6Qn022070@pimout3-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209160236.g8G2a6Qn022070@pimout3-ext.prodigy.net>; from landley@trommello.org on Sun, Sep 15, 2002 at 05:35:59PM -0400
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 05:35:59PM -0400, Rob Landley wrote:
> And reading glasses won't help someone who can't read.  Is your above set of 
> statements somehow meant to imply that a debugger cannot help someone who CAN 
> code?  (Logic.  Logic is good here.)
> 
> A similar argument would be "Nobody should own an oven.  If you can't cook 
> you'll just make a mess."
> 
> > A debugger can do some good things. Some people argue that it
> > improves productivity, which I think may be true under some
> > circomstances.
> 
> It's a tool.  Does anybody really disagree about its nature?

I can't speak for others, but my guess is that the people who don't like
debuggers don't like them for pretty much the same reasons they don't like
C++.  The tool makes bad behaviour too seductive.

It's true that one can write supportable perl but noone but a naive person
would base a multiple platform, multi-year lifespan product on perl.

It's true that one can write good systems code in C++ but experience has
shown that noone but a naive person would argue for C++ for a kernel.

Debuggers are sort of in this camp.  Yup, useful tool.  The problem is
that the real answer is that you should read and understand the code.
It's a sign of a naive programmer when you hear "this code is all shit"
and it's useful code.  That means the programmer would rather rewrite
working code than understand it enough to fix it.  Extremely common.
And extremely wrong in almost all cases.  It's *hard* to understand code.
Get over it.  Read the code, think, read again, think some more, keep
it up.  Always always always assume the guy who came before you *did*
know what they were doing.  Otherwise all you do is replace mostly working
code with brand new code that works for the *one* case in front of the
new programmer and none of the 100's of cases that the old code handled.

I don't think anyone is against debuggers.  I'm not.  I'm against people
not thinking.  I'm for people who think, who are careful, who have some
respect for code that works.

It's so much more fun to say "this code is shit, I can do better", but
whenever I've said that I've been wrong about 90% of the time.  And I'm
a pretty good programmer, I know that I shouldn't think like that.  All
I'm saying is that thinking is greater than debuggers.  Much greater.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
