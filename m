Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUJaUru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUJaUru (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 15:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUJaUrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 15:47:49 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:16261 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261362AbUJaUrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 15:47:48 -0500
Date: Sun, 31 Oct 2004 21:47:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
       Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041031204717.GF5578@elf.ucw.cz>
References: <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com> <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com> <Pine.LNX.4.61.0410272214580.877@scrub.home> <20041028005412.GA8065@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028005412.GA8065@work.bitmover.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Allow me to translate that what this means, so everyone clearly knows 
> > what's going on here:
> > The complete development history of the Linux kernel is now effectly 
> > locked into the bk format, you can get a summary of it, but that's it.
> 
> That's not even close to being the case.
> 
> 100% of the information is available on bkbits.net, diffs, comments, 
> everything, all of which you can get at with a wget in a form that
> is perfect for import into another system.

...but, if someone actually *tries* to import it into another system,
your bandwidth bill will be so huge that you'll stop bkbits.net, no?
How many terabytes would need to be transfered in order to do complete
import of linux-kernel into another system?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
