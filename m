Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbUJaTvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbUJaTvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 14:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUJaTvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 14:51:19 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:1157 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261487AbUJaTvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 14:51:17 -0500
Date: Sun, 31 Oct 2004 20:50:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>,
       Larry McVoy <lm@work.bitmover.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041031195057.GD5578@elf.ucw.cz>
References: <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org> <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org> <Pine.LNX.4.61.0410272049040.877@scrub.home> <1098913524.7778.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098913524.7778.5.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Linus, what happened to the early promises, that the data wouldn't be 
> > locked into bk? Is the massively reduced data set in the cvs repository 
> > really all we ever get out of it again?
> 
> The daily CVS snapshots seem to solve most of that. Yes BK's licensing
> model isn't free software friendly, yes its a PITA. With the CVS
> snapshots nobody is forcing your hand, its not encrypted and locked away
> behind a DRM system.

IIRC Larry announced that if we start looking into the data he *will*
encrypt it and try to lock it away...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
