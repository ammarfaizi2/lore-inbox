Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTD0XQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 19:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTD0XQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 19:16:26 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:13201 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261962AbTD0XQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 19:16:24 -0400
Date: Sun, 27 Apr 2003 16:28:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Ross Vandegrift <ross@willow.seitz.com>,
       Chris Adams <cmadams@hiwaay.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why DRM exists [was Re: Flame Linus to a crisp!]
Message-ID: <20030427232835.GM23068@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Ross Vandegrift <ross@willow.seitz.com>,
	Chris Adams <cmadams@hiwaay.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <fa.ivrgub8.1ci079c@ifi.uio.no> <20030427183553.GA955879@hiwaay.net> <20030427185037.GA23581@work.bitmover.com> <20030427220717.GA24991@willow.seitz.com> <20030427223255.GH23068@work.bitmover.com> <1051481114.15485.33.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051481114.15485.33.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 11:05:15PM +0100, Alan Cox wrote:
> Your economic model is flawed because if something needs doing enough
> someone will pay to do it. The moment the value exceeds the cost it
> should happen. 

Explain to me how BK would have happened under your (non flawed) model.
Before we gave it to you, you had no idea how to do it.  It cost
millions to get it to the point that you could see that it was valuable
by using it.

If I had said "Hey, Red Hat, how about you give me $8M so I can go
build you the perfect SCM tool" you would have laughed your ass off.
As would any other company, the amount of money it takes to do something
new is not a working amount for a single customer.

Under your model, only incremental change will occur, no customer is
ever going to fund the large amounts required for truly new work.

> As to using one companies lessons to do your work, how much did BK learn
> from what *didn't* work well in Clearcase. Rather a lot I believe. That
> learning fuels innovation.

Maybe it fuels you, it certainly doesn't fuel me.  As far as I know,
nobody who works here has ever run clearcase or looked at their file
formats.  All of the clearcase knowledge I have has come indirectly
through customers who have told me how it works.  At this point I have
a pretty good idea how it works but at no time did we ever attempt to
emulate or improve on clearcase.

A lot of people who work here have commented that they like working
here because we don't back away from the hard problems.  We don't
work at things by going "hmm, clearcase does it this way, let's see
if we can do better".  Linus told us he'd use BK when it was the best
and what we thought he meant "best" meant "it can be no better", not
"well, it's better than all the other crap out there".  The way we work
is to imagine perfection and then try and build that.  I'm really not
interested in how CVS does it or how ClearCase does it, I already know
they do it wrong.  I'm much more interested in the definition of "best".
What is the best answer?  OK, let's build that.

The fact that we took that approach is the main reason we're in business
today, there are literally hundreds of competitors out there, so if we
are only slightly better do you think anyone would know we existed?
Not a chance.  I'll bet you I can name at least 20 and probably more
like 200 SCM companies you've never heard of.  We weren't interested in
being number 201 in that list.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
