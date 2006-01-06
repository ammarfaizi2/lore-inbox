Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752559AbWAFUuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbWAFUuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbWAFUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:50:51 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:58535 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1752559AbWAFUuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:50:50 -0500
Message-ID: <43BED847.7040709@keyaccess.nl>
Date: Fri, 06 Jan 2006 21:51:19 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: DE2104X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff.

Upgraded a DEC Multia to 2.6 today and noticed its 21040 was split off 
into the "de2104x" driver. Also see it's marked "experimental" and just 
wanted to report that it seems to be working fine on the 21040 as found 
in a DEC Multia (Pentium variant):

00:08.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 
[Tulip] (rev 23)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at f880 [size=128]
         Region 1: Memory at fedff800 (32-bit, non-prefetchable) [size=128]

(PCI ID 1011:0002).

Rene.
