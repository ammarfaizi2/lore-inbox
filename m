Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUDAEyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 23:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUDAEyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 23:54:21 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:56288 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262224AbUDAEyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 23:54:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: TI Firewire controller ?
Date: Wed, 31 Mar 2004 23:54:17 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403312354.17104.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.9.48] at Wed, 31 Mar 2004 22:54:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I bought, 3 or so years back, a 1394 controller, thinking
that maybe it had a chance to become a standard, like USB
is now.

lspci -vv reports this:
00:0b.0 FireWire (IEEE 1394): Texas Instruments FireWire Controller (rev 01) (prog-if 10 [OHCI])
        Subsystem: Texas Instruments: Unknown device 8010
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e3007000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Is there any chance that this card can actually be used with modern devices?
Or should I bin it and save the couple of watts its burning?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
