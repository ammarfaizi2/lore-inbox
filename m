Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271834AbTHMLbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTHMLbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:31:05 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:28891 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271834AbTHMLbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:31:01 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 13 Aug 2003 13:30:59 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Realtek network card
Message-Id: <20030813133059.616f0faa.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

does anybody know how to make the below work (neiter 2.2.25 nor 2.4.21 seem to recognise it):

lspci --vv:

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown device 8131 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd.: Unknown device 8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 min, 64 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800
	Region 1: Memory at ee000000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


Regards,
Stephan
