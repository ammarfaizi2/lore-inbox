Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVBNS4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVBNS4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVBNS4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:56:51 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:61874 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261332AbVBNS43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:56:29 -0500
Date: Mon, 14 Feb 2005 10:56:24 -0800
To: Matthew Jacob <lydianconcepts@gmail.com>
Cc: Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Message-ID: <20050214185624.GA16029@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	Matthew Jacob <lydianconcepts@gmail.com>,
	Jeff Sipek <jeffpc@optonline.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050214020802.GA3047@bitmover.com> <58cb370e05021404081e53f458@mail.gmail.com> <20050214150820.GA21961@optonline.net> <20050214154015.GA8075@bitmover.com> <7579f7fb0502141017f5738d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7579f7fb0502141017f5738d1@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 10:17:35AM -0800, Matthew Jacob wrote:
> > So how would you suggest that we resolve it?  The protection we need is
> > that people don't get to
> > 
> >    - use BK
> >    - stop using BK so they can go work on another system
> >    - start using BK again
> >    - stop using BK so they can go work on another system
> >    ...
> > 
> 
> I guess I don't see the advantage that accrues to BitMover Inc from
> this or what you're trying to do here. I'm not trying to add kerosene
> to a flame fest here, but I'm definitely scratching my head on this
> one.
> 
> Is your concern that you don't want to provide a free tool to people
> who then turn around to compete with you? That is, you don't want BK
> to enable people to do things to harm BK and its ongoing development?

All we are trying to do is 

    1.  Provide the open source community with a useful tool.
    2.  Prevent that from turning into the open source community
        creating a clone of our tool.

The reason this is complicated is that we are giving it away for free to
lots and lots of open source people.  If we only sold it there wouldn't
be a problem, it would be 10 years before a copy appeared because far
fewer of the open source crowd would even know it existed.  Giving it
away is almost asking for it to be copied.  The license is a way to say
that the price of free use is agreement you won't use the tool to copy
the tool in any way.

I agree that this sucks, having a license that restricts your creativity
is very annoying.  On the other hand, you don't have to agree to it.
You only have to agree to it if you want the benefits of using the tool.
It's not much different than deciding whether you want to buy it, there
is a cost and a benefit and for some people the benefits outweigh the
costs and for some they don't.

If anyone can think of a better way for us to both let you use the tool
and protect our hard work, I'm listening.  The repeated outrage over the
restrictions isn't any more fun for me than it is for you.  Any answer,
however, has to take our issues into consideration as well as yours.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
