Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293033AbSB1COu>; Wed, 27 Feb 2002 21:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSB1CN6>; Wed, 27 Feb 2002 21:13:58 -0500
Received: from bitmover.com ([192.132.92.2]:57060 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293133AbSB1CNe>;
	Wed, 27 Feb 2002 21:13:34 -0500
Date: Wed, 27 Feb 2002 18:13:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: Karl <ktatgenhorst@earthlink.net>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, linux-kernel@vger.kernel.org
Subject: Re: Kernel module ethics.
Message-ID: <20020227181333.A25723@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Karl <ktatgenhorst@earthlink.net>,
	Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020228005152.GB8858@arthur.ubicom.tudelft.nl> <NDBBJHDEALBBOIDJGBNNCEOFCFAA.ktatgenhorst@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NDBBJHDEALBBOIDJGBNNCEOFCFAA.ktatgenhorst@earthlink.net>; from ktatgenhorst@earthlink.net on Wed, Feb 27, 2002 at 08:03:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 08:03:31PM -0500, Karl wrote:
> >>A couple of months ago Larry McVoy gave this excellent advice:
> 
>  >> If you really want to know where you stand, it'll cost you around
>  >> $15K and that, in my opinion, is fine. If it isn't worth $15K to
>  >> protect your code then it is worth so little to you that there really
>  >> is no good reason not to just GPL it from the start.
> 
>     I hope this is not to ignorant a question: From your post I do not
> understand what costs around $15k 

The law is a strange place.  If you really want to know what your rights
are, you need to go pay a lawyer and figure it out.  People think that
words of the GPL is the end of the story.  It's not.  Licenses are only
real after they have been tested in court.  We can all believe that the
GPL is perfect/great/whatever, and it doesn't matter.  A court of law
can look at it and say that it is crap and that's that.  Virtually all
licenses have a clause:

      If  any provision of this License is held to be unenforce-
      able, such provision shall be reformed only to the  extent
      necessary to make it enforceable.

Why is that?  Because the writers know that the license is kaka until
it is tested in court.

The most interesting question about the GPL is where does it stop?
If I link some non-GPLed .o's with GPLed source, is the source for the
.o's GPLed?  Nope, probably not.  Even the GPL acknowledges that it
can't cross certain boundaries, with the "reasonably separable" clause.
In the eyse of the law, if I can substitute in other .o's which do the
same thing as the first set of .o's, then that's a boundary.  Or at
least that's one of the things my $15K taught me.

Like I said before, unless your code is potentially worth at least a
million bucks, it's almost certainly not worth anything financially,
so GPL it.  If you think it could be worth $1M, isn't it worth $.015M
to figure out your rights?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
