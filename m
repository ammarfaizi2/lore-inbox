Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTFKBA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 21:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTFKBA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 21:00:28 -0400
Received: from smtp01.web.de ([217.72.192.180]:49953 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263273AbTFKBAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 21:00:23 -0400
Message-ID: <002b01c32fb6$beb6cbf0$3c02a8c0@saint1>
From: "Gregor Essers" <gregor.essers@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: Via KT400 and AGP 8x Support
Date: Wed, 11 Jun 2003 03:14:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In wich Kerneltree will this implented ?
2.4.x or 2.5.x ?

Ati-Drivers will not install or Run on 2.5.70 (its clear ;) )
and 2.4.20 and 2.4.21-pre7

At the End of the XFree Log will come this (2.4.21-pre7) :


(II) fglrx(0): Desc: ATI Fire GL DRM kernel module
(II) fglrx(0): Kernel Module version matches driver.
(II) fglrx(0): Kernel Module Build Time Information:
(II) fglrx(0): Build-Kernel UTS_RELEASE: 2.4.20-9
(II) fglrx(0): Build-Kernel MODVERSIONS: yes
(II) fglrx(0): Build-Kernel __SMP__: no
(II) fglrx(0): Build-Kernel PAGE_SIZE: 0x1000
(II) fglrx(0): [drm] register handle = 0xe9000000
(EE) fglrx(0): [agp] unable to acquire AGP, error "xf86_ENODEV"
(EE) fglrx(0): cannot init AGP

The init will not or can not detect the AGP-Adapture Size.


Regards 

Gregor Essers

PS: System is 

AMD XP 2000+
Radeon 9700Pro
1 GB Ram
Redhat 9 
Epox 8K9A2 Mainboard (KT400)

