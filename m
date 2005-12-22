Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVLVAZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVLVAZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 19:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVLVAZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 19:25:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17421 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964888AbVLVAZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 19:25:48 -0500
Date: Thu, 22 Dec 2005 01:25:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Un-deprecate inter_module_*
Message-ID: <20051222002546.GJ3917@stusta.de>
References: <1135210470.31433.24.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135210470.31433.24.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 07:14:30PM -0500, Lee Revell wrote:
> Andrew,
>
> I am also sick of looking at "inter_module_foo is deprecated" warnings.
> They have been deprecated for 6-12 months and obviously no one is fixing
> it.  I don't have the time or the inclination to fix it so here's a
> patch to un-deprecate inter_module_*.
>...

In recent -mm kernels (and therefore most likely in 2.6.16) you'll see 
the warnings only when your kernel contains one of the "guilty" mtd 
modules.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

