Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWCRR0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWCRR0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWCRRZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:25:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14607 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750747AbWCRRZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:25:11 -0500
Date: Sat, 18 Mar 2006 18:25:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Sean Hefty <sean.hefty@intel.com>
Cc: linux-kernel@vger.kernel.org, Roland Dreier <rolandd@cisco.com>,
       openib-general@openib.org
Subject: 2.6.16-rc6-mm2: new RDMA CM EXPORT_SYMBOL's
Message-ID: <20060318172507.GC14608@stusta.de>
References: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 04:40:56AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm1:
>...
>  git-infiniband.patch
>...
>  git trees.
>...

I'm not exactly happy that this tree adds tons of RDMA CM 
EXPORT_SYMBOL's that are neither currently used nor _GPL.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

