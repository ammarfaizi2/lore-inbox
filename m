Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVCDMmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVCDMmC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVCDMgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:36:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10119 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262942AbVCDMaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:30:52 -0500
Date: Fri, 4 Mar 2005 13:30:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugang@soulinfo.com
Subject: Re: swsusp: use non-contiguous memory on resume
Message-ID: <20050304123037.GC2203@elf.ucw.cz>
References: <20050304095934.GA1731@elf.ucw.cz> <20050304032952.4b2e456b.akpm@osdl.org> <20050304115214.GA2168@elf.ucw.cz> <200503041300.20535.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503041300.20535.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Yes, I did diff between -mm and -pavel, sorry.
> > > > 
> > > > But I can't easily generate diff against -linus because that one is
> > > > dependend on fixing order-8 allocations during suspend. So I guess
> > > > I'll just wait until that one propagates into -linus?
> > > 
> > > Just generate a patch series?
> > 
> > When #1 of the series is already in -mm? Okay, I guess we can do that.
> 
> Can I?

Yes, please go ahead.
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
