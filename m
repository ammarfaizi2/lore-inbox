Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVCBWSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVCBWSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVCBWPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:15:34 -0500
Received: from main.gmane.org ([80.91.229.2]:31942 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262503AbVCBWMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:12:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marcus Furlong <furlongm@hotmail.com>
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150
Date: Wed, 02 Mar 2005 23:42:02 +0200
Message-ID: <d05bm5$8v6$1@sea.gmane.org>
References: <Pine.GSO.4.44.0503021324200.25652-100000@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ida1.org.helsinki.fi
User-Agent: KNode/0.8.2
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson wrote:

> No obvous reason. Works fine with kernel 2.6.10
> 
> Result of lspci:
> 00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
> 00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control
> Registers (rev 02)
> 00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration
> Process Registers (rev 02)
> 00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated
> Graphics Device (rev 02)
> 00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics
> Device (rev 02)
> 00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
> 00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
> 00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
> 00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
> (rev 01)
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
> 00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
> Controller (rev 01)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97
> Audio Controller (rev 01)
> 00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01)
> 02:01.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev
> 01)
> 02:02.0 Network controller: Broadcom Corporation: Unknown device 4324 (rev
> 03)
> 02:04.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus
> Controller
> 

ditto with Inspiron 5150

lspci:
0000:00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
0000:00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
0000:00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
0000:00:01.0 PCI bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to AGP Controller (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
USB2 EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34M [GeForce FX
Go 5200] (rev a1)
0000:02:01.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T
(rev 01)
0000:02:04.0 CardBus bridge: Texas Instruments PCI4510 PC card Cardbus
Controller (rev 02)
0000:02:04.1 FireWire (IEEE 1394): Texas Instruments PCI4510 IEEE-1394
Controller


