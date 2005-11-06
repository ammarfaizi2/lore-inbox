Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVKFN7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVKFN7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 08:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVKFN7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 08:59:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16913 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750856AbVKFN7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 08:59:19 -0500
Date: Sun, 6 Nov 2005 14:59:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       axboe@suse.de
Subject: Re: [PATCH 18/25] raw: move ioctl32 code to raw.c
Message-ID: <20051106135917.GC3847@stusta.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162718.128174000@b551138y.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105162718.128174000@b551138y.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 05:27:08PM +0100, Arnd Bergmann wrote:

> The two ioctl commands for the raw driver are not used
> anywhere outside of raw.c, so move the compat handler
> there as well.
>...

Please leave this alone, the raw driver will be removed in 2.6.16.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

