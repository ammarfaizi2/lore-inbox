Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBNIY5>; Wed, 14 Feb 2001 03:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRBNIYs>; Wed, 14 Feb 2001 03:24:48 -0500
Received: from ns2.Deuroconsult.com ([193.226.167.164]:522 "EHLO
	marte.Deuroconsult.com") by vger.kernel.org with ESMTP
	id <S129108AbRBNIYa>; Wed, 14 Feb 2001 03:24:30 -0500
Date: Wed, 14 Feb 2001 10:24:21 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
To: linux-kernel@vger.kernel.org
Subject: Yamaha sound card - what driver?
Message-ID: <Pine.LNX.4.20.0102141018410.15577-100000@marte.Deuroconsult.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys!

I have a PCI sound card Yamaha. Can somebody tells me with what driver I
can use it?

02:03.0 Multimedia audio controller: Yamaha Corporation YMF-724F [DS-1
Audio Controller] (rev 03)
        Subsystem: Yamaha Corporation DS-XG PCI Audio CODEC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d9000000 (32-bit, non-prefetchable) [size=32K]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Also, I have a on-board sound card and I don't know what driver to use:
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device
2445 (rev 02)
        Subsystem: Micro-star International Co Ltd: Unknown device 3370
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=64]


Thanks in advance!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
A new Linux distribution: http://l13plus.deuroconsult.ro
http://www2.deuroconsult.ro/~catab

