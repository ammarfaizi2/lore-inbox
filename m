Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVDDIoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVDDIoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVDDIoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:44:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52102 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261177AbVDDIox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:44:53 -0400
Date: Mon, 4 Apr 2005 10:44:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Li Shaohua <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, zwane@linuxpower.ca,
       len.brown@intel.com
Subject: Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
Message-ID: <20050404084428.GA14642@elf.ucw.cz>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com> <20050403193750.40cdabb2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403193750.40cdabb2.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >
> > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> >  tree.
> 
> Should I merge that thing into mainline?  It seems that a few people are
> needing it.

Yes, it would be great. I have patch that cleans up smp/swsusp to
depend on Zwane's patch, too. Its ready AFAIK, but I'd prefer to wait
after 2.6.12 with its merge.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
