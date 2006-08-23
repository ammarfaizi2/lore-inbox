Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWHWUFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWHWUFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWHWUFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:05:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20233 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965181AbWHWUFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:05:20 -0400
Date: Wed, 23 Aug 2006 22:05:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.28-rc2
Message-ID: <20060823200519.GA19810@stusta.de>
References: <20060822230102.GC19896@stusta.de> <44EC0C6C.80502@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EC0C6C.80502@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 10:06:04AM +0200, Stefan Richter wrote:
> Adrian Bunk wrote:
> > There are still several patches pending - they will go into 2.6.16.29.
> [...]
> > Robert Hancock:
> >       Fix broken suspend/resume in ohci1394
> [...]
> 
> Alas this patch is a regression for PPC. Please apply patch "1394: fix
> for recently added firewire patch that breaks things on ppc" by Danny
> Tholen too. The latter patch is enqueued for 2.6.17.y and (so I hope)
> for 2.6.18-rc which both contain Robert's patch. I attached Danny's
> patch as I cannot safely send it inline right now.
>...
 
Thanks, applied.

> Stefan Richter

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

