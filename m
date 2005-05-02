Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVEBQl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVEBQl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVEBQh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:37:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62986 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261471AbVEBQeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:34:31 -0400
Date: Mon, 2 May 2005 18:34:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] {,un}register_ioctl32_conversion should have been removed last month
Message-ID: <20050502163429.GM3592@stusta.de>
References: <20050502014550.GG3592@stusta.de> <20050502160916.GE27150@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502160916.GE27150@muc.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 06:09:16PM +0200, Andi Kleen wrote:
> On Mon, May 02, 2005 at 03:45:51AM +0200, Adrian Bunk wrote:
> > This removal should have happened last month.
> 
> Thanks. I believe I2O and s390 are still using it though. The I2O patch
> is pending somewhere and s390 will hopefully catch up. 

There are no users in 2.6.12-rc3-mm2.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

