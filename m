Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbUJXJtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUJXJtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUJXJsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:48:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19474 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261408AbUJXJqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:46:55 -0400
Date: Sun, 24 Oct 2004 11:46:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: Re: [2.6 patch] SCSI aic7xxx: kill kernel 2.2 #ifdef's
Message-ID: <20041024094624.GB4216@stusta.de>
References: <20041023185609.GC3790@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023185609.GC3790@stro.at>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 08:56:09PM +0200, maximilian attems wrote:
> 
> previous was wrong also removed 2.4 compatibility sorry.
> resent
> 
> 
> the kjt patchset has an similar patch, that got sent to James:
> the bits below were a leftover of a janitor patch removing
> aic7xxx and aic79xx old ifdefs.
>...

Thanks for this information.

This patch seems pretty similar to my patch with the exception that it 
doesn't remove ahc_power_state_change.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

