Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282998AbRL0XKF>; Thu, 27 Dec 2001 18:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283016AbRL0XJ4>; Thu, 27 Dec 2001 18:09:56 -0500
Received: from altus.drgw.net ([209.234.73.40]:33286 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S282998AbRL0XJq>;
	Thu, 27 Dec 2001 18:09:46 -0500
Date: Thu, 27 Dec 2001 17:09:42 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Dana Lacoste <dana.lacoste@peregrine.com>,
        "'Larry McVoy'" <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BK scales, Bitmover doesn't [was Re: BK stuff ]
Message-ID: <20011227170941.I25200@altus.drgw.net>
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2A3B@ottonexc1.ottawa.loran.com> <20011227133951.M25698@work.bitmover.com> <20011227155956.G25200@altus.drgw.net> <20011227142359.O25698@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011227142359.O25698@work.bitmover.com>; from lm@bitmover.com on Thu, Dec 27, 2001 at 02:23:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 02:23:59PM -0800, Larry McVoy wrote:
> On Thu, Dec 27, 2001 at 03:59:56PM -0600, Troy Benjegerdes wrote:
> > (I'm quite sure this is off-topic, but oh well :-/ )
> 
> Seems like your outgoing mail filter needs some work if you know it's
> off topic and you post anyway, but what the hey, it's Christmas.
> 
> > However, the real problem I see is that althought Bitkeeper (the product)  
> > scales very well, Bitmover (the company) does NOT. Bitmover needs income 
> > to scale, and I'm worried that if BK takes off for kernel development, 
> > the demands on Bitmover from kernel developers will far outstrip the 
> > increase in income they get from 'commercial' developers. If this happens, 
> > it's only going to end in everyone getting pissed off. 
> 
> This is way off topic.  I could make similar claims about people using
> what your company, Monta Vista, does but you don't see me posting in the
> kernel list about their layoffs, business practices, etc.  I certainly
> could, but it shows no class (not that I've been accused of having lots
> of class, but FUD seems too tasteless for me).

<disclaimer>I am NOT trying to represent MontaVista here in any way.. I'd
have these same issues if I was working for them or not. I really didn't
want to bring MontaVista into this due to previous incidents.</disclaimer>

I suppose you could make similiar claims. However, there is a very
important and subtle difference.  MontaVista is NOT in any position to
tell developers using 'MontaVista' kernels that they must STOP using our
kernel, since it is GPL'ed.

Bitmover, however, is VERY MUCH in a position to tell developers to STOP 
using Bitkeeper. As a matter of fact, it's in your license.

> Regardless, to put minds at ease, we're fine.  While we would welcome
> more revenue (who wouldn't?), we've never had a layoff in our 4 year
> history and aren't planning any.  In addition, we've managed to support
> you and the PPC team for almost 2 years without it being a problem,
> I'm not sure why it should become a problem now.  Oh yeah, tack on MySQL
> as well, that's been under BK for longer than Linux/PPC.  Of course, if
> you are worried about it, since Monta Vista has gotten so much benefit
> out of BK, they could help ensure the continued development by buying
> a support contract.  Hint, hint.
> 
> What if we do go out of business?  What's wrong with that?  If we go
> under, BK reverts to a pure GPL license.  That can't be a problem,
> right?

But potentially not for 6 months, during which time the use of bitkeeper 
is legally dubious, and probably not possible without altering the binary 
(i.e., if openlogging.org goes down), opening up another mess.

> Seems to me it's a win/win.  We either stick around and support it because
> the business model is sound, or we go under and you get it like any other
> open source product.  Yeah, it's better if we stick around because BK
> is pretty complex, but if the open source crowd can handle the kernel,
> gcc, X, etc, they can handle the BK source base, so I really don't see
> the problem here.  What am I missing?

If you don't stick around, OR get unhappy with us using BK, we have a 
problem. Yes, you have some very nice fallbacks, which I thank you for, 
but the fallbacks are still going to cause a great deal of pain.

The real problem is what if you have 300 kernel developers that suddenly 
start costing you support costs of $5,000 a month?

According to the license, that's only 4 months before the 'group of 
licensees' using BK for the kernel cost you $20,000, at which point the 
BKL allows you to cut them off.

If Bitmover ever has to tell someone to quit using BK under the BKL, that, 
IMHO, is a lose/lose situation, for everyone.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
