Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVCSVdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVCSVdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVCSVdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:33:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24489 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261848AbVCSVdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:33:08 -0500
Date: Sat, 19 Mar 2005 22:32:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: swsusp: Remove arch-specific references from generic code
Message-ID: <20050319213252.GB1835@elf.ucw.cz>
References: <20050316001207.GI21292@elf.ucw.cz> <200503191159.32569.rjw@sisk.pl> <20050319132815.4f51a7e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319132815.4f51a7e5.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> swsusp-suspend_pd_pages-fix.patch

Could you drop this one? It is "fixing" unused macro, we don't want it
going anywhere.

> suspend-to-ram-update-videotxt-with-more-systems.patch
> 
> I've been ducking all the "swsusp_restore crap" patches.  Pavel, could you
> please aggregate, test and resend everything when the dust has settled?

Ok.


									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
