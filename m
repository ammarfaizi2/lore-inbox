Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVBXQeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVBXQeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVBXQeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:34:17 -0500
Received: from math.ut.ee ([193.40.36.2]:60879 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261708AbVBXQeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:34:14 -0500
Date: Thu, 24 Feb 2005 18:34:03 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Sven Luther <sven.luther@wanadoo.fr>
cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       Sven Hartge <hartge@ds9.gnuu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Kujau <evil@g-house.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
In-Reply-To: <20050224160657.GB11197@pegasos>
Message-ID: <Pine.SOC.4.61.0502241832510.21289@math.ut.ee>
References: <20041206185416.GE7153@smtp.west.cox.net>
 <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos>
 <Pine.SOC.4.61.0502241746450.21289@math.ut.ee> <20050224160657.GB11197@pegasos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
> meanwhile, you can try :
>
>  http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd

This seems to work fine: onboard scsi is OK, pci nic with de4x5 is OK 
too. Haven't got more PCI cards in there currently.

-- 
Meelis Roos (mroos@linux.ee)
