Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbUKUCGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUKUCGj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 21:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUKUCGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 21:06:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2833 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261727AbUKUCGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 21:06:38 -0500
Date: Sun, 21 Nov 2004 03:06:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: source@mvista.com, Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: drivers/video/aty/xlinit.c unused
Message-ID: <20041121020636.GH2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems drivers/video/aty/xlinit.c should be used with 
CONFIG_FB_ATY_XL_INIT, but currently, it's under no circumstances 
compiled...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

