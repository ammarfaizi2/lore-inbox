Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUKOQ2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUKOQ2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 11:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUKOQ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 11:28:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43525 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261628AbUKOQ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 11:28:12 -0500
Date: Mon, 15 Nov 2004 17:22:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Smart@Emulex.Com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI: misc possible cleanups
Message-ID: <20041115162232.GA19860@stusta.de>
References: <0B1E13B586976742A7599D71A6AC733C12E6F2@xbl3.ma.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B1E13B586976742A7599D71A6AC733C12E6F2@xbl3.ma.emulex.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 08:57:08AM -0500, James.Smart@Emulex.Com wrote:

> Please don't back out the additions to scsi_transport.c!!!
> 
> These were hard-fought additions, and required by our driver, which we should call for upstream approval in the near future.

Sorry that I didn't state my intention clear enough:

I did not want to propose to simply apply this patch.
It was intended as a "FYI: the following code is _currently_ unused".

> -- James S

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

