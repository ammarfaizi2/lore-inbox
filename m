Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVALWZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVALWZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVALWZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:25:11 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:21154 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261526AbVALWYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:24:14 -0500
Date: Wed, 12 Jan 2005 23:24:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10][Suspend] - Time problems
Message-ID: <20050112222400.GA2139@elf.ucw.cz>
References: <200501110235.37039.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501110235.37039.shawn.starr@rogers.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When resuming from suspend, I noticed the clock is waay off (its 10:16pm, it 
> shows 2:34AM EST time). This is even after a reboot the bios now shows wrong 
> time?

Yes, see for example thread "2.6.10-mm2: swsusp regression
[update]". Nigel has some patch that should fix it...

									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
