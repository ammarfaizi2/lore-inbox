Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWHOSNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWHOSNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWHOSNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:13:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46606 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030431AbWHOSNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:13:22 -0400
Date: Tue, 15 Aug 2006 20:13:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Martin Samuelsson <sam@home.se>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: drivers/media/video/bt866.c: array overflows
Message-ID: <20060815181320.GB7813@stusta.de>
References: <20060814232337.GZ3543@stusta.de> <20060815080618.50200f6b.sam@home.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815080618.50200f6b.sam@home.se>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 08:06:18AM +0200, Martin Samuelsson wrote:
> On Tue, 15 Aug 2006 01:23:37 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > The Coverity checker spotted the following two array overflows:
> 
> Nice coverity checker! *pat pat*
> 
> Now, a question: Where can I find the latest version of the files that concern the avs6eyes driver? In april, I got this mail that informed me that the avs6eyes driver patch had been removed from the -mm tree. I figured that it was removed because of the lack of internal V4L2 support when V4L1 was about to be chucked out from the kernel. I looked around a little to see if I could find the driver, but I couldn't.
> 
> Obviously, as you've found bugs in it, I didn't look in the right places. Where, pray tell, did the little critter go?
>...

It's in 2.6.18-rc4.

> /Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

