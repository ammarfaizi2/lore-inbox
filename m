Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVCDJUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVCDJUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVCDJUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:20:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3974 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262703AbVCDJQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:16:41 -0500
Date: Fri, 4 Mar 2005 10:16:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/power/disk.c trivial cleanups
Message-ID: <20050304091623.GA1551@elf.ucw.cz>
References: <20050303231543.GA28559@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303231543.GA28559@slurryseal.ddns.mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> * Remove duplicate include.
> 
> * Avoid "mode set to ''" message when error updating /sys/power/disk.
> 
> Signed-off-by: Todd Poynor <tpoynor@mvista.com>

Duplicate remove killed, thanks. I do not think debugging print
requires that much care...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
