Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVL3NcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVL3NcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVL3NcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:32:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22022 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751262AbVL3NcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:32:00 -0500
Date: Fri, 30 Dec 2005 14:31:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230133159.GX3811@stusta.de>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051229143846.GA18833@infradead.org> <1135868049.2935.49.camel@laptopd505.fenrus.org> <20051229153529.GH3811@stusta.de> <20051229154241.GY22293@devserv.devel.redhat.com> <p73oe2zexx9.fsf@verdi.suse.de> <20051230094045.GA5799@elte.hu> <20051230101443.GA13072@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230101443.GA13072@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 11:14:43AM +0100, Ingo Molnar wrote:
>...
> note: my focus is still mostly on CC_OPTIMIZE_FOR_SIZE (which is only 
> offered if CONFIG_EMBEDDED is enabled) - if you want a larger kernel 
> optimized for speed, do not enable it.

Since 2.6.15-rc6, CC_OPTIMIZE_FOR_SIZE only depends on EXPERIMENTAL.

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

