Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVACRZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVACRZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVACRXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:23:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17424 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261506AbVACRWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:22:03 -0500
Date: Mon, 3 Jan 2005 18:22:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: roland@topspin.com, mshefty@ichips.intel.com, halr@voltaire.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: infiniband: rename two source files?
Message-ID: <20050103172202.GH2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/infiniband/core/Makefile contains the following:

<--  snip  -->

...
ib_sa-y :=                      sa_query.o

ib_umad-y :=                    user_mad.o

<--  snip  -->

Is it planned to add other objects to ib_sa and/or ib_umad, or would you 
accept a patch to rename the source files?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

