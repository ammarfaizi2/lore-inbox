Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVBNRMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVBNRMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 12:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVBNRMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 12:12:30 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:14258 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261491AbVBNRMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 12:12:21 -0500
Date: Mon, 14 Feb 2005 09:12:19 -0800
To: linux-os <linux-os@analogic.com>
Cc: Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
Message-ID: <20050214171219.GA8846@bitmover.com>
Mail-Followup-To: lm@bitmover.com, linux-os <linux-os@analogic.com>,
	Jeff Sipek <jeffpc@optonline.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050214020802.GA3047@bitmover.com> <58cb370e05021404081e53f458@mail.gmail.com> <20050214150820.GA21961@optonline.net> <20050214154015.GA8075@bitmover.com> <Pine.LNX.4.61.0502141113200.4019@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502141113200.4019@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >So how would you suggest that we resolve it?  The protection we need is
> >that people don't get to
> >
> >   - use BK
> >   - stop using BK so they can go work on another system
> >   - start using BK again
> >   - stop using BK so they can go work on another system
> 
> What??? Why not? BK is a PROGRAM. You can't tell somebody
> that once they use some program in one job, they can't
> use it again. What kind of "protection" are you claiming?

It is a program that comes with a license.  Licenses have terms which
survive the termination of the license, that's industry standard, they
all have such terms.

In this case the situation is unusual because we have a program that is
ahead, in some ways, of all the other programs out there that do the
same thing.  We'd like to protect that lead.  We put that lead at risk
by giving you BK for free, that's more or less suicide because the open
source world has a long track record of copying that which they find
useful.  We don't want you to copy it.  If you can't agree to not copy
it then you don't get to use it in the first place.

This is not that weird people, people sign NDA's which are far more
draconian every day.  Read any software license, they all have the
non-compete as well, they hide it in the reverse engineering restriction.
Those licenses don't care if you are competing with them or not, they
do a blanket do-not-reverse-engineer no matter who you are.  We tried
to be specific so that we were restricting the tiny subset of the world
that wants to hack SCM, not everyone else.  Because that's different
than standard language we get screamed at.  What you aren't figuring
out is that the standard language is more restrictive, not less.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
