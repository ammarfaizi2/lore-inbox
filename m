Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVDBWQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVDBWQl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDBWQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:16:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32421 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261301AbVDBWNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:13:47 -0500
Date: Sun, 3 Apr 2005 00:09:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fix u32 vs. pm_message_t in drivers/mmc,mtd,scsi
Message-ID: <20050402220921.GC1347@elf.ucw.cz>
References: <20050402212954.GA2152@elf.ucw.cz> <20050402134110.24ece2e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402134110.24ece2e2.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  This is last of the series. I tried to submit patches through their
> >  mainainers (when they were easy to determine, our MAINTAINERS file
> >  sucks).
> 
> You mean that there are patches in addition to these seven?

Yes, there are 7 more. They were sent to l-k and maintainers. I'll
bounce them to you.

> This sort of thing is a pain all round whichever way we do it.  Right now
> the various subsystem trees are about as small as they ever get, so the
> time is good to push all this in.
> 
> You should go through the whole -mm, check to see whether there is work
> pending in bk-*.patch which also needs conversion.

Ok, I'll do some grepping (tommorow or monday).
								Pavel
									

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
