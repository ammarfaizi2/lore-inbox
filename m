Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVIBUwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVIBUwQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVIBUwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:52:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5643 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750873AbVIBUwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:52:14 -0400
Date: Fri, 2 Sep 2005 22:52:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: is include/linux/platform.h a dead header?
Message-ID: <20050902205204.GU3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

it seems that exept for the default_idle() prototype, the complete 
include/linux/platform.h is obsolete.

Is there a reason to keep it, or should we delete this header?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

