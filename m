Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267663AbUG3JSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267663AbUG3JSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 05:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUG3JSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 05:18:47 -0400
Received: from gprs214-254.eurotel.cz ([160.218.214.254]:63875 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267663AbUG3JSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 05:18:45 -0400
Date: Fri, 30 Jul 2004 11:18:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Per kthread freezer flags (Version 2)
Message-ID: <20040730091831.GA22541@elf.ucw.cz>
References: <1090999301.8316.12.camel@laptop.cunninghams> <20040729190438.GA468@openzaurus.ucw.cz> <1091139864.2703.24.camel@desktop.cunninghams> <20040729224422.GG18623@elf.ucw.cz> <1091143537.2703.61.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091143537.2703.61.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Okay.. how does this look?
> 
> I applied your changes and fixed a couple of typos I noticed. I also
> added support for the hcvs thread, which is new since rc1-mm1. (This is
> against rc2-mm1).

Looks okay, thanks.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
