Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264401AbRFUJ7c>; Thu, 21 Jun 2001 05:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264912AbRFUJ7X>; Thu, 21 Jun 2001 05:59:23 -0400
Received: from bubba.NMSU.Edu ([128.123.3.39]:24808 "EHLO bubba.NMSU.Edu")
	by vger.kernel.org with ESMTP id <S264401AbRFUJ7M>;
	Thu, 21 Jun 2001 05:59:12 -0400
Date: Thu, 21 Jun 2001 03:59:08 -0600 (MDT)
From: SPENCE <sspence@NMSU.Edu>
To: <linux-kernel@vger.kernel.org>
Subject: AGP for 760MP chipset
Message-ID: <Pine.LNX.4.30.0106210352310.15192-100000@gauss.NMSU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I managed to get my hands on a dual athlon box and get it working fairly
well.  I have been unable to get agpgart working however because it is an
unrecognized chipset.  It would be great to get this working and I would
be happy to supply any info or do some testing for the developers.  On a
side note the kernel cannot identify many of the interfaces. For example:

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c
(rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7410 (rev
02)
00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7411
(rev 01)
00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7413 (rev 01)
00:07.4 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7414
(rev 07)
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev
04)
00:0a.1 Input device controller: Creative Labs SB Live! (rev 01)
00:0c.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895
(rev 01)
00:0f.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T]
(rev 78)
00:10.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T]
(rev 78)
01:05.0 VGA compatible controller: nVidia Corporation NV15 Bladerunner
(Geforce2 GTS) (rev a4)

Though it's not that big of a deal it would make it look more purty.

Steven


