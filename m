Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVCMSiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVCMSiB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 13:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVCMSiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 13:38:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26263 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261418AbVCMSgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 13:36:51 -0500
Date: Sun, 13 Mar 2005 19:36:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11: keyboard stopped working after memory upgrade
Message-ID: <20050313183635.GD1427@elf.ucw.cz>
References: <200503121421.03983.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503121421.03983.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm just having a weird problem with 2.6.11.  Namely, the keyboard stopped
> working after I'd added more RAM to the box (Asus L5D notebok, x86-64
> kernel).  It works on 2.6.11-mm1.

Custom DSDT? DSDTs are known to depend on ammount of memory...
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
