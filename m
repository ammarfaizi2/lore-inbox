Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbUKGOjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUKGOjR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 09:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUKGOjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 09:39:17 -0500
Received: from gprs214-134.eurotel.cz ([160.218.214.134]:11649 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261621AbUKGOjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 09:39:15 -0500
Date: Sun, 7 Nov 2004 15:38:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Subject: Re: 2.6.10-rc1-mm3: swsusp problems w/ ALSA driver, IRQs on AMD64
Message-ID: <20041107143858.GF1176@elf.ucw.cz>
References: <200411062014.08202.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411062014.08202.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm having some troubles with swsusp on 2.6.10-rc1-mm3 (Athlon 64-based laptop 
> w/ NForce3 chipset), although I don't think that swsusp itself is to
> blame.

Did it work ok on other kernels? Does it work when you rmmod intel8x0
before suspend?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
