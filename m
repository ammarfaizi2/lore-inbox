Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSF0Mna>; Thu, 27 Jun 2002 08:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSF0Mn3>; Thu, 27 Jun 2002 08:43:29 -0400
Received: from [62.70.58.70] ([62.70.58.70]:6275 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316821AbSF0Mn2> convert rfc822-to-8bit;
	Thu, 27 Jun 2002 08:43:28 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: SCx200 audio support?
Date: Thu, 27 Jun 2002 14:43:35 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206271443.35524.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

Any plans to support the National Geode SC1200 integrated audio chipset?

In lspci -vvv it looks like this

00:12.3 Multimedia audio controller: National Semiconductor Corporation SCx200 
Audio
        Subsystem: National Semiconductor Corporation SCx200 Audio
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at 40011000 (32-bit, non-prefetchable) [size=4K]


thanks

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

