Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbUKVJGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUKVJGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUKVJGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:06:04 -0500
Received: from math.ut.ee ([193.40.5.125]:22990 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261996AbUKVJF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:05:26 -0500
Date: Mon, 22 Nov 2004 10:42:49 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Li Shaohua <shaohua.li@intel.com>
cc: matthieu castet <castet.matthieu@free.fr>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <1101086961.2940.7.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.SOC.4.61.0411221040310.28550@math.ut.ee>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> 
 <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> 
 <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee> 
 <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee> 
 <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee> 
 <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee> 
 <41A0F893.9020106@free.fr> <1101086961.2940.7.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Adam, I think a boot option (such as pnpacpi=off) is required. Users
> possibly want to use pnpbios or BIOS is buggy.

Additionally, I see more pnp devices with pnpbios (16) than with pnpbios 
(13). Is this normal?

-- 
Meelis Roos (mroos@linux.ee)
