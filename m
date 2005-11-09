Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVKIURI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVKIURI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbVKIURH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:17:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29444 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750716AbVKIURG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:17:06 -0500
Date: Wed, 9 Nov 2005 21:17:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dominik Brodowski <linux@brodo.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove drivers/pcmcia/pcmcia_ioctl.c
Message-ID: <20051109201704.GC4047@stusta.de>
References: <20051107200351.GL3847@stusta.de> <20051107213722.GA11233@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107213722.GA11233@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 09:37:22PM +0000, Russell King wrote:
> On Mon, Nov 07, 2005 at 09:03:51PM +0100, Adrian Bunk wrote:
> > This patch contains the scheduled removal of 
> > drivers/pcmcia/pcmcia_ioctl.c plus the fallout of additional cleanups 
> > after this removal.
> 
> Please don't prempt maitainers removing code which they've listed in
> feature-removal.txt.  By doing so, you may discourage maintainers from
> listing stuff in there.
> 
> Instead, it may be worth sending a short reminder instead?

I sent reminders to all three peoples with scheduled removals for this 
month last week. Dominik was the only one who didn't answer.

Sending a patch, no matter how good or bad it is, is often a good way 
for getting an answer from a maintainer.  ;-)

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

