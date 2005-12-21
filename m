Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVLUVdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVLUVdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVLUVdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:33:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:268 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932202AbVLUVdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:33:22 -0500
Date: Wed, 21 Dec 2005 22:33:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.j
Subject: Re: [RFC: 2.6 patch] include/linux/irq.h: #include <linux/smp.h>
Message-ID: <20051221213321.GC3888@stusta.de>
References: <20051221012750.GD5359@stusta.de> <20051221024133.93b75576.akpm@osdl.org> <20051221110421.GA26630@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221110421.GA26630@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 11:04:22AM +0000, Russell King wrote:
> On Wed, Dec 21, 2005 at 02:41:33AM -0800, Andrew Morton wrote:
> > Yes, it's basically always wrong to include asm/foo.h when linux/foo.h
> > exists. 
> 
> There's always an exception to every rule.  linux/irq.h is that
> exception for the above rule.

Why?

> Russell King

cu
Adrian

--

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

