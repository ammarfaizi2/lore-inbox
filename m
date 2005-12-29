Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVL2QUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVL2QUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVL2QUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:20:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40720 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750794AbVL2QUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:20:22 -0500
Date: Thu, 29 Dec 2005 17:20:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [2.6.15-rc7 patch] Reject SRAT tables that don't cover all memory
Message-ID: <20051229162020.GK3811@stusta.de>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org> <20051229133902.GD3811@stusta.de> <20051229160741.GI11515@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229160741.GI11515@wotan.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 05:07:41PM +0100, Andi Kleen wrote:
> On Thu, Dec 29, 2005 at 02:39:02PM +0100, Adrian Bunk wrote:
> > Below is a patch by Andi Kleen from kernel Bugzilla #5758 fixing a 
> > post-2.6.14 regression.
> 
> WTF are you submitting my patches? Please don't do this - I am perfectly
> capable to do this on my own when the time is ripe for them. For this
> patch that's post 2.6.15 and after more testing.

According to the bug logs this is a regression in 2.6.15-rc, and it's 
not good if 2.6.15 will not boot on some machines where 2.6.14 did.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

