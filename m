Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVBNVa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVBNVa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVBNVa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:30:57 -0500
Received: from ns1.flexabit.net ([64.198.230.130]:49033 "EHLO ns1.flexabit.net")
	by vger.kernel.org with ESMTP id S261506AbVBNVar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:30:47 -0500
From: Tom Felker <tfelker2@uiuc.edu>
To: lm@bitmover.com, Matthew Jacob <lydianconcepts@gmail.com>,
       Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Date: Mon, 14 Feb 2005 15:30:47 -0600
User-Agent: KMail/1.7.2
References: <20050214020802.GA3047@bitmover.com> <7579f7fb0502141017f5738d1@mail.gmail.com> <20050214185624.GA16029@bitmover.com>
In-Reply-To: <20050214185624.GA16029@bitmover.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502141530.47019.tfelker2@uiuc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 February 2005 12:56 pm, Larry McVoy wrote:

> All we are trying to do is
>
>     1.  Provide the open source community with a useful tool.
>     2.  Prevent that from turning into the open source community
>         creating a clone of our tool.
>
> The reason this is complicated is that we are giving it away for free to
> lots and lots of open source people.  If we only sold it there wouldn't
> be a problem, it would be 10 years before a copy appeared because far
> fewer of the open source crowd would even know it existed.  Giving it
> away is almost asking for it to be copied.  The license is a way to say
> that the price of free use is agreement you won't use the tool to copy
> the tool in any way.
>
> I agree that this sucks, having a license that restricts your creativity
> is very annoying.  On the other hand, you don't have to agree to it.
> You only have to agree to it if you want the benefits of using the tool.
> It's not much different than deciding whether you want to buy it, there
> is a cost and a benefit and for some people the benefits outweigh the
> costs and for some they don't.
>
> If anyone can think of a better way for us to both let you use the tool
> and protect our hard work, I'm listening.  The repeated outrage over the
> restrictions isn't any more fun for me than it is for you.  Any answer,
> however, has to take our issues into consideration as well as yours.

I really think the fewer restrictions you put on BK's use, the less likely it 
will be copied.  When the open source community copies something, it's not out 
of a desire to screw somebody over.  It's because they had an itch, a 
software need that couldn't easily be fulfilled otherwise, a demand.

Apparently there is a demand for good SCM, and BK can satisfy this, and you've 
done the very admirable thing of letting the open source community use BK at 
no cost.  But by putting such a heavy restriction on its use, you create a 
large portion of the community who won't or can't use it, and who therefore 
need a "copy" of it, which is exactly what you are trying to prevent.

This segment wouldn't be slowed down much by the restrictions anyway.  As long 
as the BT users who ask for features aren't "working on" the project (however 
you define that), they're almost certainly safe.  And even if they are, if 
they can afford a day in court, they have a chance of winning.  (I'm NOT 
suggesting anybody do this, just saying it's possible.)

Better for you would be to just not create this segment in the first place, by 
making the license as unrestrictive as you can while still making money.  If 
you take the non-compete clause out and leave it at "open repository and 
logs," then BT would be good enough for most everybody, and you wouldn't have 
to worry about a copy until after we're all using the Hurd.

Just a thought,
-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

Code is speech!

