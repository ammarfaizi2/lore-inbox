Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVBNPku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVBNPku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 10:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVBNPkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 10:40:49 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:44721 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261451AbVBNPkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 10:40:20 -0500
Date: Mon, 14 Feb 2005 07:40:15 -0800
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Message-ID: <20050214154015.GA8075@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Jeff Sipek <jeffpc@optonline.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050214020802.GA3047@bitmover.com> <58cb370e05021404081e53f458@mail.gmail.com> <20050214150820.GA21961@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214150820.GA21961@optonline.net>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 10:08:20AM -0500, Jeff Sipek wrote:
> On Mon, Feb 14, 2005 at 01:08:58PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Sun, 13 Feb 2005 18:08:02 -0800, Larry McVoy <lm@bitmover.com> wrote:
> > > is to clarify the non-compete stuff.  We've had some people who have
> > > indicated that they believed that if they used BK they were agreeing
> > > that they would never work on another SCM system.  We can see how it
> > > is possible that people would interpret the license that way but that
> > > wasn't our intent.  What we would like to do is change the language to
> > > say that if you use BK you are agreeing that you won't work on another
> > > SCM for 1 year after you stop using BK.  But after that you would be
> > 
> > I don't even plan working on some SCM system, but being
> > tainted for 1 year for just *using* BK is not worth the price IMHO.
> 
> I agree, the price is just too high. No matter how much I like BK, I
> would give it up.

The way some people are reading the license the price is even higher,
they think it is a forever tainted license as it stands today.  I've had
specific requests to clarify this part of the license.

So how would you suggest that we resolve it?  The protection we need is
that people don't get to

    - use BK
    - stop using BK so they can go work on another system
    - start using BK again
    - stop using BK so they can go work on another system
    ...

We could say that if you stop using BK and work on another system then
you can't ever use it again.  We're not going to do that, we've already
had to calm the fears of people who found themselves in that situation
for their job.  

So what do you want us to do?  This isn't a change to take stuff from
you, it's a change that some of your peers asked us to do so they could
use BK (and it would be nice if the people who wanted this are reading
this thread and will speak up so it doesn't look like I'm making it up).

What we've been doing so far is telling people who were worried to act as
if there were a year long gap and they have been happy with that answer
but they are asking for us to put it in the license so they don't have
to depend on some email based side agreement.

It would be nice if you could talk this over amongst yourselves and
suggest an answer.  I can see why you think it is a bad change, I'm hoping
that you can see why other people may want us to make this sort of change.
Maybe if you think about it a bit you'll come up with a better solution.
Or maybe we will.  Either way, I can't be very involved in the process,
I'm taking off for a week long vacation starting Wednesday and I won't
have email access.  Which will be a good way to make sure that if this 
turns into a flame war I won't be prolonging it.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
