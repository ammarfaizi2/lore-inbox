Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTKTIop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTKTIoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 03:44:44 -0500
Received: from ns.schottelius.org ([213.146.113.242]:49598 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S264128AbTKTIon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 03:44:43 -0500
Date: Thu, 20 Nov 2003 09:44:47 +0100
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Matt_Wu@acersoftech.com.cn
Cc: linux-kernel@vger.kernel.org
Subject: M5451 / problems adjusting the mixer
Message-ID: <20031120084447.GM3748@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matt, List!

I am using the M5451 driver to use sound on my ECS A530:

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)
        Subsystem: Elitegroup Computer Systems: Unknown device 0f22
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at effac000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Is it a software bug, a non programmed feauture of this particular
implementation or a general problem with this hardware?

In any case: Howto fix it? Can I help you with testing drivers here or
delivering you with hardware information?

Have a nice day,

Nico
