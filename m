Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269150AbUJFIzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269150AbUJFIzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 04:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269160AbUJFIzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 04:55:18 -0400
Received: from gprs214-1.eurotel.cz ([160.218.214.1]:43136 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269150AbUJFIzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 04:55:13 -0400
Date: Wed, 6 Oct 2004 10:54:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3[+recent swsusp patches]: swsusp kernel-preemption-unfriendly?
Message-ID: <20041006085458.GC1255@elf.ucw.cz>
References: <200410052314.25253.rjw@sisk.pl> <20041005212757.GB5763@elf.ucw.cz> <200410061055.39698.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410061055.39698.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It looks like there's a probel with the kernel preemption vs swsusp:
> > 
> > It is not in kernel preemption, see that NULL pointer dereference? Try
> > this one...
> [-- snip --]
> 
> Is it against -mm?  It does not apply cleanly to -rc3, so I've applied it 
> manually.

It was against -suse... Did it help?
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
