Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136069AbREBXGc>; Wed, 2 May 2001 19:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136058AbREBXGX>; Wed, 2 May 2001 19:06:23 -0400
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:8452
	"HELO ns1.theoesters.com") by vger.kernel.org with SMTP
	id <S136104AbREBXGD>; Wed, 2 May 2001 19:06:03 -0400
From: "Phil Oester" <phil@theoesters.com>
To: <linux-kernel@vger.kernel.org>
Subject: Complete support for Intel 815 chipset?
Date: Wed, 2 May 2001 16:06:00 -0700
Message-ID: <LAEOJKHJGOLOPJFMBEFEMEOPDHAA.phil@theoesters.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may not matter in terms of performance, but many devices on Intel 815
chipset machines show up as unknown.  Any ideas when (or if) full support
for the 815 is planned?

-Phil

Output of lspci:

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and
Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset
Graphics Controller]  (rev 02)
00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 02)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 02)
00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev 02)
00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 02)
00:1f.3 SMBus: Intel Corporation: Unknown device 2443 (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445
(rev 02)
01:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
08)

