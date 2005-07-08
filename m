Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVGHW0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVGHW0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVGHWYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:24:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40965 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262920AbVGHWXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:23:20 -0400
Date: Sat, 9 Jul 2005 00:23:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: RFC: schedule obsolete OSS drivers for removal
Message-ID: <20050708222317.GN3671@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are several OSS drivers for hardware that also has ALSA drivers.

My current plan is:
- let all such OSS drivers depend on a OBSOLETE_OSS_DRIVER option
- wait three months
- remove the drivers

Are there any objections against such a plan?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

