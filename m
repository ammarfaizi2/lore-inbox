Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUHHSW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUHHSW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUHHSW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:22:56 -0400
Received: from gprs214-188.eurotel.cz ([160.218.214.188]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266133AbUHHSWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:22:53 -0400
Date: Sun, 8 Aug 2004 20:22:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Status with pmdisk/swsusp merge ?
Message-ID: <20040808182234.GA620@elf.ucw.cz>
References: <1091679494.5225.186.camel@gaston> <Pine.LNX.4.50.0408051517141.6736-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408051517141.6736-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What is the status with those patches ?
> >
> > I have some additional stuff to drop on top of it, including the basic
> > PPC support, some renumbering of the states as discussed earlier, some
> > driver fixes etc.... but at this point, I feel it would be more handy
> > to get those in only after Patrick core changes have been merged with
> > Linus. Do we wait for 2.6.9 to open ?
> 
> I intend to try and merge my tree with Linus once he releases 2.6.8,
> modulo any bugs that crop up between now and then. Feel free to send me
> the patches to fix up ppc before then, and I will merge them as well.

Sounds good.

> As far as the device power management stuff goes, I'm wading through the
> discussion right now..

Hopefully we can at least switch to enums so that we clear any
confusion....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
