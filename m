Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135175AbRAQLiw>; Wed, 17 Jan 2001 06:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135198AbRAQLie>; Wed, 17 Jan 2001 06:38:34 -0500
Received: from kea.grace.cri.nz ([131.203.4.51]:35084 "EHLO kea.grace.cri.nz")
	by vger.kernel.org with ESMTP id <S135175AbRAQLiL>;
	Wed, 17 Jan 2001 06:38:11 -0500
Date: Wed, 17 Jan 2001 06:36:56 -0500 (EST)
Message-Id: <200101171136.GAA11202@whio.grace.cri.nz>
From: roger@kea.grace.cri.nz
To: linux-kernel@vger.kernel.org
CC: roger@kea.grace.cri.nz
Subject: Linux v.2.4.0 and Netscape 4.76?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After making extensive enquiries elsewhere I have been advised to post
this question to the kernel mailing list. Joseph Anthony wrote recently
to the list about a similar matter (I think).

The problem: symptoms

It concerns the behaviour of Netscape after upgrading from kernel
2.2.16 to 2.4.0. With the new kernel Netscape locates and connects to
a URL, and sometimes begins to download, but then it just sits there
indefinitely (without downloading any data). This happens quite
consistently since I upgraded to 2.4.0 (about 2 weeks ago).  ppp,
telnet, ftp all function satisfactorily as far as I can determine
(however that's not to say that the problem doesn't originate with
ppp in the kernel). There are a few packet errors (about 1 per 1000).
Netscape continues to function well with Linux kernel 2.2.16 -- but
not with 2.4.0.

People have suggested various things (eg upgrading programs to later
versions). I have tried most of them, without success. Somebody
recommended I turn to the kernel mailing list. If this is not the
right place for my enquiry I apologize (where else?). But if somebody
recognizes these symptoms I would be very grateful for a diagnosis...

Thanks,
Roger Young
(roger@maths.grace.cri.nz)

Motherboard: GA-6VX7-4X with Via Apollo Pro AGP chipset
CPU: P3/733 MHz
Memory: 256 Mb SDRAM
Graphics: GA 660+ with NVIDIA RIVA TNT2A chipset (32 Mb DRAM)
Modem: Dynalink 56K external modem. Serial port IRQ4, I/O 03F8-03FF. 

Distribution: Slackware 7.1
Linux kernel: 2.4.0 (2.2.16)
PPP: 2.4.0
modutils: 2.4.0
XFree86: 4.0.1
Netscape: 4.76
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
