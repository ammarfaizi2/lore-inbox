Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVKND4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVKND4S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 22:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVKND4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 22:56:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35343 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750876AbVKND4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 22:56:17 -0500
Date: Mon, 14 Nov 2005 04:56:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc1: kswapd crash
Message-ID: <20051114035616.GD5735@stusta.de>
References: <4377D1B2.8070003@rtr.ca> <20051114004758.GA5735@stusta.de> <4377FFA7.4030400@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4377FFA7.4030400@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 10:08:23PM -0500, Mark Lord wrote:
> Adrian Bunk wrote:
> >
> >Perhaps your vmware modules?
> 
> No, not those.  They've been there for years.
>...

So why did you delete the tainted line from the Oops output you sent?

It might be a bug in the kernel or a bug in your vmware modules exposed 
by the new kernel.

Unless the opposite is proven, the latter is assumed...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

