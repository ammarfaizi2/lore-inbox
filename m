Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRBXMEZ>; Sat, 24 Feb 2001 07:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129271AbRBXMEQ>; Sat, 24 Feb 2001 07:04:16 -0500
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:22914 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S129270AbRBXMEG>; Sat, 24 Feb 2001 07:04:06 -0500
Posted-Date: Sat, 24 Feb 2001 13:04:05 +0100 (MET)
Date: Sat, 24 Feb 2001 13:03:36 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200102241203.NAA24228@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: PCI: Setting latency timer of device 00:02.0 to 64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

What does mean this message ? Why is the latency timer resetted ?
PCI: Found IRQ 11 for device 00:02.0
PCI: Setting latency timer of device 00:02.0 to 64

from lspci :
					
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 max, 64 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at db800000 (32-bit, non-prefetchable) [size=4K]

And why is the latency timer reseted ?

---------
Regards
		Jean-Luc
