Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263190AbUKTWiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbUKTWiB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 17:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbUKTWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 17:36:28 -0500
Received: from gprs214-248.eurotel.cz ([160.218.214.248]:1408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263190AbUKTWeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 17:34:08 -0500
Date: Sat, 20 Nov 2004 23:29:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some machines
Message-ID: <20041120222940.GA983@elf.ucw.cz>
References: <1100811950.3470.23.camel@mhcln03> <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03> <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston> <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Sorry, that's beyond my abilities. That's why I'm posting here. I'm not
> >> even sure that it's the radeon which is acting up here.
> > 
> > Have you tried with radeonfb in your kernel config ?
> 
> In the general case, it's harder to resume systems using

This is not the general case. Read the whole thread, generic PCI
resume was causing problems.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
