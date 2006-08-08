Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWHHTXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWHHTXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWHHTXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:23:11 -0400
Received: from 1wt.eu ([62.212.114.60]:41485 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1030224AbWHHTXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:23:10 -0400
Date: Tue, 8 Aug 2006 21:07:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Time to forbid non-subscribers from posting to the list?
Message-ID: <20060808190752.GE8776@1wt.eu>
References: <f19298770608080407n5788faa8x779ad84fe53726cb@mail.gmail.com> <17624.29292.673708.654588@cse.unsw.edu.au> <f19298770608080441h68fb6696h845b0fd1ed5a7128@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19298770608080441h68fb6696h845b0fd1ed5a7128@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 03:41:15PM +0400, Alexey Zaytsev wrote:
> On 8/8/06, Neil Brown <neilb@suse.de> wrote:
> >On Tuesday August 8, alexey.zaytsev@gmail.com wrote:
> >> Hello, list.
> >>
> >> What are the objections to makeing lkml and other lists at vget
> >> subscribers-only?
> >
> >Yes.  Many.  I think this is in the FAQ. (hhmm.. just looked, it isn't 
> >exactly).
> >
> >> Non-subscribers messages could still be allowed after moderation.
> >> I get 1/4 of my spam from lkml, and see no benefit from allowing
> >> non-subscribers to freely post to the list. If you are not subscribed,
> >> you just have to wait until your mail gets approved by the moderator,
> >> and it is not hard to subscribe anyway.
> >
> >We want to barrier to posting to be low so that people will post bug
> >reports.  We want to hear about bug reports. really really.

100% agreed. Many (I mean MANY) posters add a "PS: please CC me as I'm
not subscribed" line. This means whe might lose their reports while they're
often the most important ones.

Another problem is that many of us post from multiple addresses (work, home,
kernel.org, ...), and this must be taken into account to. Next, some spammers
use *valid* posters addresses, so those will pass through your filters anyway.
I'm already getting several spams a day pretending to emerge from several
LKML posters, so spamlists are also built from large mailing lists.

> >Were you volunteering to be a moderator?  What sort of minimum delay
> >would you guarantee :-)
> 
> If we had a large moderators group, we could do mail processing within 
> minutes.

We already have this large moderators group : all the users. I really
don't mind getting that small rate of spams in my LKML folder. Those
are very easy to identify at first glance, it will be harder when they
will begin with [PATCH] or things like this. You need 15 seconds to
hit the "D" key to remove 30 of them, that's OK.

> I'm not familiar with any mail list systems, is the mail validation
> done with a web-interface?
> If we could get incoming traffic delivered to the moderator's mailbox,
> rather than appear on the web interface, it would be not hard for him
> to ack/nack certain e-mails. We could even get the traffic split
> betweem moderators, e.g. one gets N e-mails, afters processing them,
> he gets an other N e-mails, and if he does not process theese e-mails
> within M hours, they are sent to an other moderator. But here it's
> only my imagination, maybe people with some mailing list
> administration experience could give more ideas. And yes, if the
> moderators group is large enough, I'm ready to come in.

Your description is generally interesting, but would require a lot of
work, and I'm not sure you'll find many kind people as you who would
devote a great part of their time to moderate such a list.

Regards,
Willy

