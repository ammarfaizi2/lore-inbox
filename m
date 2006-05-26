Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWEZMeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWEZMeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWEZMeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:34:22 -0400
Received: from math.ut.ee ([193.40.36.2]:65255 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750732AbWEZMeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 08:34:21 -0400
Date: Fri, 26 May 2006 15:34:17 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Ingo Oeser <netdev@axxeo.de>
cc: kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: Safe remote kernel install howto (Re: [Bugme-new] [Bug 6613]
 New: iptables broken on 32-bit PReP (ARCH=ppc))
In-Reply-To: <200605261429.36078.netdev@axxeo.de>
Message-ID: <Pine.SOC.4.61.0605261532140.26383@math.ut.ee>
References: <200605251004.k4PA4Lek007751@fire-2.osdl.org> <4475FCFC.5000701@trash.net>
 <Pine.SOC.4.61.0605261008090.14762@math.ut.ee> <200605261429.36078.netdev@axxeo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Unfortunatlety, 2.6.15 does not boot on this machine so I'm locked out
>> remotely at the moment.
>
> Here it my paranoid boot setup:

Thanks, but it's not much use here, since the machine is a PReP powerpc 
machine that can boot one kernel from disk (directly loaded from boot 
partition, no fancy bootloader) or netboot via serial console for test 
kernels. However, if the test kernel hangs, it hangs and I would need 
remote power cycling device that I do not have.

-- 
Meelis Roos (mroos@linux.ee)
