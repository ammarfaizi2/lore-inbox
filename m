Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271789AbRICTqi>; Mon, 3 Sep 2001 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271788AbRICTq2>; Mon, 3 Sep 2001 15:46:28 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:46857 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S271817AbRICTqO>; Mon, 3 Sep 2001 15:46:14 -0400
Message-ID: <3B93DE17.92CF408E@delusion.de>
Date: Mon, 03 Sep 2001 21:46:31 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Parallel Port doesn't detect EPP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have just two questions regarding parallel port support with my
Via686a chipset:

#1) EPP is no longer listed as supported transfer mode, but it used
    to be.

#2) What is that "Can't probe parallel port" message?

Regards,
Udo.

PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=3
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_daisy: aa5500ff(88)
parport0: assign_addrs: aa5500ff(88)
parport0: Printer, Hewlett-Packard HP LaserJet 6L
parport_pc: Strange, can't probe Via 686A parallel port: io=0x378, irq=7, dma=3
