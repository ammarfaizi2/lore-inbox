Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbULFNgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbULFNgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULFNgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:36:44 -0500
Received: from gprs214-164.eurotel.cz ([160.218.214.164]:51584 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261312AbULFNgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:36:37 -0500
Date: Mon, 6 Dec 2004 14:36:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: wakeup_pmode_return jmp failing?
Message-ID: <20041206133625.GB1213@elf.ucw.cz>
References: <41B084B4.1050402@sun.com> <41B09D4B.3090906@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B09D4B.3090906@tmr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is suspend even supposed to be generally functional? I thought it was a 
> WIP not expected to work except on certain models which have been
> hand 

Suspend to work should work, only thing that needs to be hand-tuned is
video resume. But when he sees "Lin", video is not problem for him.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
