Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVLNSmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVLNSmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVLNSmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:42:51 -0500
Received: from math.ut.ee ([193.40.36.2]:59326 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S964869AbVLNSmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:42:50 -0500
Date: Wed, 14 Dec 2005 20:42:42 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: alan@lxorguk.ukuu.org.uk, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Updated PATA libata patch set
In-Reply-To: <20051213150134.DD33914BB8@rhn.tartu-labor>
Message-ID: <Pine.SOC.4.61.0512142030130.7748@math.ut.ee>
References: <20051213150134.DD33914BB8@rhn.tartu-labor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Big update to the ata_piix driver. Add MWDMA support, fix numerous
> bugs in the original code and ide/pci/piix.c. Should be as functional as
> the ide/pci code if not better but no doubt has a few new bugs to
> replace the old ones.
>
> - Drivers for original piix and mpiix (broken and unsupported by the
> ide/pci piix driver)

Is there any hope that piix4 mwdma now works again? I'm refering to this 
bug that appeared in 2.4.19:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.3/1332.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0208.3/1128.html

If there is any hope, I will get a equivalnet computer to test (this 
spaecific computer is still in production use).

-- 
Meelis Roos (mroos@linux.ee)
