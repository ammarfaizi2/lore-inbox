Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSEZQ63>; Sun, 26 May 2002 12:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316225AbSEZQ63>; Sun, 26 May 2002 12:58:29 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:61201 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316223AbSEZQ62>;
	Sun, 26 May 2002 12:58:28 -0400
Date: Sun, 26 May 2002 10:55:06 -0600
From: yodaiken@fsmlabs.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: yodaiken@fsmlabs.com, David Woodhouse <dwmw2@infradead.org>,
        Larry McVoy <lm@bitmover.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Linus Torvalds <torvalds@transmeta.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526105506.A20002@hq.fsmlabs.com>
In-Reply-To: <20020526082142.C18843@hq.fsmlabs.com> <Pine.LNX.4.21.0205261722570.17583-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 05:30:27PM +0200, Roman Zippel wrote:
> > It means just what it says.
> 
> For that I would need a patent lawyer, what I can't afford.
> On the other hand other people did get an advice from a lawyer, these 
> people asking you again if the interpretation of that lawyer is correct
> and they get no answer from you, so that they still don't know if they get
> sued by you.

If you are using purely GPL software or some other non-commercial software
then you don't need a lawyer. If you are using standard Linux software
that does not make use of the method, you don't need a a lawyer. If you
are developing commercial RT software that does make use of the method, then
there is no generic and simple rule, just as there is no generic and simple
rule for what is "derived work" and what is "simple aggregation".
People who are developing such software can (A) ask us for specific
information about whether we think the software is covered or
(B) get their own legal advice. If we say that a commercial license is not
required, they can rely on it. What we cannot offer is a rule that
can be defeated by syntactic means. For example, writing a chunk of code
that is practicing the method, and splitting it into parts so you
can hide the  valuable IP in one component while GPL'ing the
rest, is not acceptable. Taking what is certainly an OS module that
is required to be GPL and turning on the "user mode" bit and calling it
an "application" does not work either. Similarly, I doubt
as one  can write a non-GPL module for gcc, run it under NetBSD as a BSD 
kernel module and claim benefit of the BSD License to close it.

Our patent is a US patent: people in Europe who say they are worried about 
RTLinux patent issues may really have more to worry about if they are
using code that should be inheriting our GPL license and are incorporating
it in non-GPL software without our permission. 
Well, there are also some
somewhat similar German software patents that might also worry them.

Embedded software is one of the most highly patented areas. It is beyond
irony when our European friends tell us that companies like Schneider
are horrified by the existence of the patent.  Please forgive my 
cynicism, but most of the complaints seem to come from people who want to 
write software for money for customers that own 
huge patent portfolios.  If you are engaged in such a business, then you 
clearly have no principled disagreement with patent and other 
software licenses. As Churchill put it, we have established what you are,
we are only quibbling about the price.

I don't claim to be writing software in order to benefit mankind. We
have a business that, like old-fashioned businesses, stresses 
profits although I hope very much we are living up to our ethical
principles as well.  
For  both ethical and practical business reasons, we are 
in no way inclined to try to strangle off competing uses of the patented
method. Our commercial license fees are _low_ and we have not turned down
anyone who asked for licenses.  

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

