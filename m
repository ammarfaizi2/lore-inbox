Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbUKUTOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUKUTOA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 14:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUKUTOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 14:14:00 -0500
Received: from math.ut.ee ([193.40.5.125]:32198 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261790AbUKUTN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 14:13:59 -0500
Date: Sun, 21 Nov 2004 20:51:20 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: matthieu castet <castet.matthieu@free.fr>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <41A0DB78.2010807@free.fr>
Message-ID: <Pine.SOC.4.61.0411212050490.11420@math.ut.ee>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>
 <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>
 <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>
 <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>
 <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>
 <41A0DB78.2010807@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could I have the log from smsc-ircc2 when it failed with pnpacpi ?

found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): IrDA not enabled
smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02

-- 
Meelis Roos (mroos@linux.ee)
