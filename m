Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVIDFX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVIDFX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 01:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVIDFX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 01:23:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26386 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751132AbVIDFX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 01:23:59 -0400
Date: Sun, 4 Sep 2005 07:23:52 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Brand-new notebook useless with Linux...
Message-ID: <20050904052351.GB30279@alpha.home.local>
References: <200509031859_MC3-1-A720-F705@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509031859_MC3-1-A720-F705@compuserve.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 06:58:00PM -0400, Chuck Ebbert wrote:
> I just bought a new notebook.  Here is the output from lspci using the latest
> pci.ids file from sourceforge:

You seem to be surprized by the contents. When I recently changed my 
work notebook (dead screen on the previous one), it took me nearly 6
months to find one which suits my needs (serial, floppy, ...) and to
ensure that everything in it was supported. I've refused several ones
because there was no clear indication that they hosted supported hardware.
So I'm a bit amazed by your reaction, you seem to have bought the first
cheap K8 you saw in a store.

If I were you, I'd return it.

Regards,
Willy

> 00:00.0 Host bridge: ATI Technologies Inc RS480 Host Bridge (rev 01)
> 00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f
> 00:13.0 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.1 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
> 00:13.2 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller
> 00:14.0 SMBus: ATI Technologies Inc IXP SB400 SMBus Controller (rev 11)
> 00:14.1 IDE interface: ATI Technologies Inc Standard Dual Channel PCI IDE Controller ATI
> 00:14.3 ISA bridge: ATI Technologies Inc IXP SB400 PCI-ISA Bridge
> 00:14.4 PCI bridge: ATI Technologies Inc IXP SB400 PCI-PCI Bridge
> 00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller (rev 02)
> 00:14.6 Modem: ATI Technologies Inc: Unknown device 4378 (rev 02)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 01:05.0 VGA compatible controller: ATI Technologies Inc ATI Radeon XPRESS 200M 5955 (PCIE)
> 05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
> 05:02.0 Network controller: Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g Wireless LAN Controller (rev 02)
> 05:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
> 05:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host Controller
> 05:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
> 05:09.4 Class 0805: Texas Instruments PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI7421, PCI7611, PCI7621 Secure Digital (SD) Controller
> 
> None of these work and I can find no support anywhere for them:
> 
> SMBus
> Audio ("unknown codec")
> Modem ("no codec available")
> Wireless
> FlashMedia
> SD/MMC
> 
> Additionally, the system clock runs at 2x normal speed with PowerNow enabled.
> 
> Am I stuck with running XP on this thing?
> 
> __
> Chuck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
