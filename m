Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVLUWdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVLUWdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLUWdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:33:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30220 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751115AbVLUWda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:33:30 -0500
Date: Wed, 21 Dec 2005 23:33:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.jp
Subject: Re: [RFC: 2.6 patch] include/linux/irq.h: #include <linux/smp.h>
Message-ID: <20051221223329.GB3917@stusta.de>
References: <20051221012750.GD5359@stusta.de> <20051221024133.93b75576.akpm@osdl.org> <20051221110421.GA26630@flint.arm.linux.org.uk> <20051221213321.GC3888@stusta.de> <20051221214806.GJ1736@flint.arm.linux.org.uk> <20051221221114.GA3917@stusta.de> <20051221222131.GL1736@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221222131.GL1736@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:21:31PM +0000, Russell King wrote:
> 
> The point is _exactly_ as the above quotation between Andrew Morton
> and myself.  I'm sure it's not me being thick because it's absolutely
> damned obvious from the above.
> 
> Andrew said: "Yes, it's basically always wrong to include asm/foo.h
> when linux/foo.h exists."
> 
> That statement is a rule.  I assert that this is an incorrect statement
> and I assert that there is a proven case where this statement is incorrect.
> 
> Hence, to avoid people reading Andrew's misleading statement, I followed
> up on precisely _that_ point and _that_ point alone.

OK, now I got it:

You are arguing only against Andrew's statement of a general rule,
not against my patch.

Sorry for my misunderstading.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

