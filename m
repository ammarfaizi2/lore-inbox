Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUIPUtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUIPUtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUIPUtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:49:23 -0400
Received: from gprs214-103.eurotel.cz ([160.218.214.103]:30848 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268237AbUIPUtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:49:22 -0400
Date: Thu, 16 Sep 2004 22:49:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm5: double fault on resume on Athlon64 w/ NForce 3
Message-ID: <20040916204908.GA8772@elf.ucw.cz>
References: <200409132357.13582.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409132357.13582.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> JFYI, I get a double fault on resume on an Athlon64-based box:

Try the patch I sent to lkml few minutes ago.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
