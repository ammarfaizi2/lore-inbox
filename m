Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbULFKpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbULFKpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 05:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbULFKpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 05:45:11 -0500
Received: from bay101-f22.bay101.hotmail.com ([64.4.56.32]:2598 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261490AbULFKpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 05:45:05 -0500
Message-ID: <BAY101-F22378AB0D9016021445311ABB40@phx.gbl>
X-Originating-IP: [195.8.161.21]
X-Originating-Email: [riley_howard_williams@hotmail.com]
In-Reply-To: <kiiZIHd0T0000153f@hotmail.com>
From: "Riley Williams" <riley_howard_williams@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: nVidea Graphics card not recognised by lspci
Date: Mon, 06 Dec 2004 10:44:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 06 Dec 2004 10:45:01.0509 (UTC) FILETIME=[A34A9F50:01C4DB80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

The enclosed is the output from `lspci -vvv` for the video card on one of my 
systems. Can anybody tell me any more about this card, as "Unknown device 
0322" isn't too useful a description.

If any further information is required, please tell me where to find it and 
I will report it here.

Best wishes from Riley.

*****************************************************************************

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0322 
(rev a1) (prog-if 00 [VGA])
Subsystem: Unknown device 1682:203c
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 64 (1250ns min, 250ns max)
Interrupt: pin A routed to IRQ 11
Region 0: Memory at d1000000 (32-bit, non-prefetchable) [size=16M]
Region 1: Memory at e0000000 (32-bit, prefetchable) [size=256M]
Expansion ROM at <unassigned> [disabled] [size=128K]
Capabilities: [60] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [44] AGP version 3.0
Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


