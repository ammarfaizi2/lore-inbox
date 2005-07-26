Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVGZQd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVGZQd6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVGZQbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:31:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55302 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261929AbVGZQaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:30:24 -0400
Date: Tue, 26 Jul 2005 18:30:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050726163013.GW3160@stusta.de>
References: <20050726150837.GT3160@stusta.de> <1122393073.18884.29.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122393073.18884.29.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 11:51:13AM -0400, Lee Revell wrote:
> On Tue, 2005-07-26 at 17:08 +0200, Adrian Bunk wrote:
> > This patch schedules obsolete OSS drivers (with ALSA drivers that 
> > support the same hardware) for removal.
> 
> How many non-obsolete OSS drivers were there?

I haven't counted them, but there are still many.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

