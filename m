Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUFROSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUFROSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUFROSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:18:17 -0400
Received: from 82-147-17-1.dsl.uk.rapidplay.com ([82.147.17.1]:63301 "HELO
	82-147-17-1.dsl.uk.rapidplay.com") by vger.kernel.org with SMTP
	id S265148AbUFROSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:18:16 -0400
From: Mark Watts <mrwatts@fast24.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Adaptec AHA-F950 FC card
Date: Fri, 18 Jun 2004 15:18:14 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406181518.15014.mrwatts@fast24.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know if this card is supported in linux, and what driver to use if it 
is?

00:07.0 Fibre Channel: Adaptec AIC-1160 [Family Fibre Channel Adapter] (rev 
02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at dfffd000 (64-bit, non-prefetchable) [size=4K]
        Region 3: I/O ports at cc00 [size=256]
        Expansion ROM at dfe80000 [disabled] [size=64K]

Cheers,

Mark.
