Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267253AbUGNM1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267253AbUGNM1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUGNM1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:27:17 -0400
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:41600 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267253AbUGNM1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:27:13 -0400
Date: Wed, 14 Jul 2004 13:55:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: netdev@oss.sgi.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040714115523.GC2269@elf.ucw.cz>
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >What is the status of ipw2100? Is there chance that it would be pushed
> >into mainline?
> >
> >I have few problems with that:
> >
> >* it will not compile with gcc-2.95. Attached patch fixes one problem
> >but more remain.
> 
> I've given up hope on that. Don't think it'll ever compile on 2.95. I'm 
> using ndiswrapper and it works nicely.

No, I think that can be fixed... I'll rather fix ipw2100 than use
ndiswrapper.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
