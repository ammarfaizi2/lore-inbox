Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVB0REv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVB0REv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVB0REu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:04:50 -0500
Received: from gprs215-59.eurotel.cz ([160.218.215.59]:24276 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261439AbVB0REk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:04:40 -0500
Date: Sun, 27 Feb 2005 18:04:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: madduck@madduck.net
Subject: Re: swsusp logic error?
Message-ID: <20050227170428.GI1441@elf.ucw.cz>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050226153905.GA8108@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226153905.GA8108@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Sorry for the late reply, I've been strung up with work. I tried
> your suggestion on another machine, with a vanilla 2.6.10 kernel and
> a single swap device, twice the size of the physical RAM; I get
> exactly the same result. The swap device cannot be found.
> 
> What to try next?

Ugh, too late, I already forgot what went wrong for you. Anyway try
reading Documentation/power/swsusp.txt and/or going to 2.6.11-rc4. If
that does not help, debug with printk :-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
