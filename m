Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVKHDma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVKHDma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVKHDma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:42:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48392 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932403AbVKHDm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:42:29 -0500
Date: Tue, 8 Nov 2005 04:42:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jean Tourrilhes <jt@hpl.hp.com>, rmk@arm.linux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Future of DONGLE_OLD drivers?
Message-ID: <20051108034226.GL3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at drivers/net/irda/Kconfig, it seems all DONGLE_OLD drivers 
except EP7211_IR have more recent drivers.

My questions are:

Is there still any reason to keep the DONGLE_OLD drivers except 
EP7211_IR?

Is the Cirrus Logic EDB-7211 evaluation board still an actively 
maintained and supported platform or an obsolete platform?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

