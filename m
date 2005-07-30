Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263157AbVG3UrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbVG3UrL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVG3UrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:47:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41671 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263157AbVG3UrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:47:08 -0400
Date: Sat, 30 Jul 2005 22:46:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Underwood <basicmark@yahoo.com>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050730204658.GC9418@elf.ucw.cz>
References: <20050730102236.B9652@flint.arm.linux.org.uk> <20050730113350.62722.qmail@web30304.mail.mud.yahoo.com> <20050730212820.G26592@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730212820.G26592@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Note that I'm maintaining the code and will be
> > > publishing a new set
> > > of patches for it based upon Pavel's fixes.
> > 
> > Thanks. I'll check them out then.
> 
> Since there appears to be some interest in these, I'll set about
> converting the audio bits to ALSA rather than Nico's SA11x0 audio
> driver.  I thought no one was using these chips anymore, and the
> driver was dead!
> 
> I've recently edited the mcp structure which may make things less
> awkward for others, and I'll continue moving in that direction
> with this driver.
> 
> You can get the updated patches at:
> 
> 	http://zeniv.linux.org.uk/pub/people/rmk/ucb/

Okay, what's the plan with mainstreaming those? Do they stay in
drivers/misc?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
