Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269176AbUIRKXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269176AbUIRKXN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 06:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269179AbUIRKXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 06:23:13 -0400
Received: from gprs214-222.eurotel.cz ([160.218.214.222]:41856 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269176AbUIRKXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 06:23:12 -0400
Date: Sat, 18 Sep 2004 12:22:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Cc: ajoshi@shell.unixbox.com,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Radeon: do not blank screen during suspend
Message-ID: <20040918102255.GC832@elf.ucw.cz>
References: <20040915112652.GA21386@elf.ucw.cz> <1095482822.3574.24.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095482822.3574.24.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This stops ugly flashing from radeon during suspend/resume, please
> > apply,
> 
> Shoud be fine.
> 
> BTW. What is the status with Patrick merge of pmdisk & swsusp ? Has it
> been merged at all ? (No time to check at the moment). I still hope I'll
> find some time to do real work on it (& cleanup the ppc support that I
> had working experimentally at OLS) sooner or later...

It was merged to Andrew, then to Patrick and now it is waiting on
Linus to pull it from patrick, if I understand it correctly.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
