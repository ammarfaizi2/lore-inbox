Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVAORLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVAORLo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 12:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVAORLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 12:11:44 -0500
Received: from smtp1.sloane.cz ([62.240.161.228]:25848 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S262301AbVAORLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 12:11:42 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Satelco EasyWatch DVB-T PCMCIA card
Date: Sat, 15 Jan 2005 18:11:34 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501151811.34382.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

can anybody around tell me something about this card? I bought it, but none 
DVB driver works with it and under windows it doesn't work with included 
drivers too...

0000:03:00.0 Multimedia video controller: Unknown device 0432:0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 20800200 (32-bit, non-prefetchable) [disabled] 
[size=128]
        Region 1: Memory at 20800000 (32-bit, non-prefetchable) [disabled] 
[size=512]
        Capabilities: [78] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

http://www.satelco.de/htm/shop/mobilset/index.htm

Is this card unsupported or destroyed??

Thanks Michal
