Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVLJVq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVLJVq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 16:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVLJVq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 16:46:29 -0500
Received: from vsmtp1.tin.it ([212.216.176.141]:15589 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S964976AbVLJVq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 16:46:29 -0500
From: ldonesty <jorge78_REMOVE_ME_@inwind.it>
Subject: Re: Linux 2.6.15-rc5 bad page with fglrx on Radeon X300
Date: Sat, 10 Dec 2005 22:46:33 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.12.10.21.46.32.489895@inwind.it>
References: <5fVeA-714-27@gated-at.bofh.it> <5iksa-2mf-3@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, 10 Dec 2005 22:30:10 +0100, Brice Goglin ha scritto:

>>
> Does anybody out there have ATI drivers working on Radeon X300
> on 2.6.15-rc5 (or -rc[234]) ? They released fglrx 8.20.8 on december 8th.
> I thought they would have fixed the driver for 2.6.15.
> But, I still get bad page and X programs freezing.
> 
I'm using 2.6.15-rc2-ck with Ati proprietary drivers (packaged for Debian
by Flavio Stanchina) and I don't see great problems here.

**********

(II) Primary Device is: PCI 01:00:0
(II) ATI Proprietary Linux Driver Version Identifier:8.19.10
(II) ATI Proprietary Linux Driver Release Identifier: LGDr8.19g1
(II) ATI Proprietary Linux Driver Build Date: Nov  9 2005 17:51:16
(II) ATI Proprietary Linux Driver Build Information: autobuild-rel-r6-8.19.1-driver-lnx-226030
(--) Chipset MOBILITY RADEON X300 (M22 5460) found

***********
Chiba:/home/io# dpkg -l | grep fgl
ii  fglrx-driver                       8.19.10-1                     Video driver for the ATI graphics accelerato
ii  fglrx-kernel-src                   8.19.10-1                     Kernel module source for the ATI graphics ac
 
***********
	
			Mario
-- 
Il reggiseno e' uno strumento democratico perche' separa la destra dalla
sinistra, solleva le masse e attira i popoli.

www.debianizzati.org | Founder Member
Mario "Ldonesty" Di Nitto --- [Linux Registered User #334335]

