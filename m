Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVCRLpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVCRLpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 06:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVCRLpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 06:45:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33428 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261587AbVCRLpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 06:45:50 -0500
Date: Fri, 18 Mar 2005 12:45:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, rusty@rustcorp.com.au
Subject: Re: CPU hotplug on i386
Message-ID: <20050318114536.GA14399@elf.ucw.cz>
References: <20050316132151.GA2227@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316132151.GA2227@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I tried to solve long-standing uglyness in swsusp cmp code by calling
> cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
> available on i386. Is there way to enable CPU_HOTPLUG on i386?

BTW Li Shaohua has prototype smp/S3 implementation. I'll take detailed
look at that one.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
