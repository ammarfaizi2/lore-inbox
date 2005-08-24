Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVHXL06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVHXL06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVHXL06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:26:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42513 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750887AbVHXL05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:26:57 -0400
Date: Wed, 24 Aug 2005 13:26:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Al Viro <viro@www.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (11/43) Kconfig fix (infiniband and PCI)
Message-ID: <20050824112655.GQ5603@stusta.de>
References: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E7gaT-00079k-Ax@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 10:45:41PM +0100, Al Viro wrote:

> infiniband uses PCI helpers all over the place (including the core parts) and
> won't build without PCI.
>...

CONFIG_INFINIBAND=y and CONFIG_PCI=n compiles for me on i386.

Can you post the compile error you got?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

