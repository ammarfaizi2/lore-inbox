Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVKNAsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVKNAsB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 19:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVKNAsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 19:48:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25870 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750814AbVKNAsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 19:48:00 -0500
Date: Mon, 14 Nov 2005 01:47:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc1: kswapd crash
Message-ID: <20051114004758.GA5735@stusta.de>
References: <4377D1B2.8070003@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4377D1B2.8070003@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 06:52:18PM -0500, Mark Lord wrote:

> For what it's worth, here's an oops from kswapd.
> Lots of stuff was active at the time, so I have no idea
> what triggered this.

Perhaps your vmware modules?

Does this happen with an unpatched 2.6.15-rc1 ftp.kernel.org kernel and 
without loading any modules not shipped with this kernel since booting?

> Cheers
> -Mark
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

