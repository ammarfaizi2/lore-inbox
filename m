Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273577AbRI3PMy>; Sun, 30 Sep 2001 11:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273578AbRI3PMe>; Sun, 30 Sep 2001 11:12:34 -0400
Received: from [209.38.98.99] ([209.38.98.99]:19386 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S273577AbRI3PMb>;
	Sun, 30 Sep 2001 11:12:31 -0400
Message-Id: <200109301514.f8UFEvC09449@srvr201.castmark.com>
Content-Type: text/plain; charset=US-ASCII
From: Fred Jackson <fred@arkansaswebs.com>
To: linux-kernel@vger.kernel.org
Subject: ac97 audiu on ECS K7S5A ?
Date: Sun, 30 Sep 2001 10:11:56 -0500
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Is there support fort the ac97 audio on a ECS K7S5A main board?
please cc me as I'm no longer subscribed..

thanks
Fred


[root@bits /root]# lspci -v
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 
(rev 01)
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 
00 [Normal decode])        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: cde00000-cfefffff
        Prefetchable memory behind bridge: c9c00000-cdcfffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Flags: bus master, medium devsel, latency 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) 
(prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) 
(prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Flags: bus master, medium devsel, latency 64, IRQ 12
        Memory at cffff000 (32-bit, non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller 
(A,B step)
        Flags: bus master, fast devsel, latency 128
        I/O ports at ff00 [size=16]

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]: 
Unknown device 7012 (rev a0)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at dc00 [size=256]
        I/O ports at d800 [size=64]
        Capabilities: [48] Power Management version 2
 
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet (rev 90)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Flags: bus master, medium devsel, latency 64, IRQ 12
        I/O ports at d400 [size=256]
        Memory at cffdd000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at cffa0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
 
00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0201
        Flags: medium devsel, IRQ 11
        I/O ports at d000 [size=32]
 
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) 
(prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
        Memory at ca000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at cfef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0
 
[root@bits /root]#
