Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTEJTnK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTEJTnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:43:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:30882 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264486AbTEJTnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:43:08 -0400
Date: Sat, 10 May 2003 12:55:45 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net and BK->CVS gateway
Message-ID: <20030510195545.GA26447@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030510154352.GK679@phunnypharm.org> <20030510162207.GB24686@work.bitmover.com> <20030510192253.GA24276@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510192253.GA24276@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 03:23:03PM -0400, Jan Harkes wrote:
> On Sat, May 10, 2003 at 09:22:07AM -0700, Larry McVoy wrote:
> > In other words, I think you're safe.  Famous last words, we'll now discover
> > that our friends in .cz have written the world's first BK virus and it 
> > corrupts the CVS tree.  Or something.  Regardless, we've taken steps to
> > make sure the CVS data is safe and restorable.
> 
> Could you please stop making random accusations? Pavel probably has

Could you please stop whining about something that was clearly a joke?
Jeeze, get a sense of humor already.

> better things to do than to write a 'BK virus'. And about that comment
> 'taking steps to make sure CVS data is safe'...
> 
> On Sat, May 10, 2003 at 07:04:55AM -0700, Larry McVoy wrote:
> > Dave, I put RH 7.3 on there but didn't install any security fixes, you get
> > to do that fun job if you care.
> 
> Hmm, let's see https://rhn.redhat.com/errata/rh73-errata-security.html

Well aren't we the do goody little sys admin.  For your information, those
patches were applied before I opened up the box, turned on accounts, or
turned on CVS.

    [root@kernel root]# up2date -u
    ...
    None of the packages you requested were found, or they are already updated.

> I sure hope Dave cared, because I wouldn't even consider plugging an
> unpatched anything into the network in the first place. Let alone
> announce this fact to a widely distributed mailing list.

So are you volunteering to manage that machine?  Or just complaining?

It *never* fails to amaze me.  I spend my friday night in a colo, spend
saturday morning finishing the job, and some arm chair quarterback
has to come along and rudely tell me that I'm not doing it right?!?
Would it be any surprise if the next time there is a problem we just
let it slide for a few weeks before it gets fixed?

    "it's about being nice to people especially the ones that help you."

What he said.
