Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVICXB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVICXB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 19:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVICXB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 19:01:57 -0400
Received: from siaag2ag.compuserve.com ([149.174.40.140]:16773 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S1751284AbVICXB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 19:01:57 -0400
Date: Sat, 3 Sep 2005 18:58:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Brand-new notebook useless with Linux...
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509031859_MC3-1-A720-F705@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just bought a new notebook.  Here is the output from lspci using the latest
pci.ids file from sourceforge:

00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f
00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI
00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge
00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 02)
00:14.6 Modem: ATI Technologies Inc: Unknown device 4378 (rev 02)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:05.0 VGA compatible controller: ATI Technologies Inc ATI Radeon XPRESS 200M 5955 (PCIE)
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
05:02.0 Network controller: Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g Wireless LAN Controller (rev 02)
05:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
05:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host Controller
05:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
05:09.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller

None of these work and I can find no support anywhere for them:

SMBus
Audio ("unknown codec")
Modem ("no codec available")
Wireless
FlashMedia
SD/MMC

Additionally, the system clock runs at 2x normal speed with PowerNow enabled.

Am I stuck with running XP on this thing?

__
Chuck
