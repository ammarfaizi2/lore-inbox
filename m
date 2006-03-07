Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWCGUWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWCGUWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWCGUWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:22:19 -0500
Received: from c-68-35-68-128.hsd1.nm.comcast.net ([68.35.68.128]:35531 "EHLO
	deneb.dwf.com") by vger.kernel.org with ESMTP id S932242AbWCGUWT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:22:19 -0500
Message-Id: <200603072022.k27KMGFE004530@deneb.dwf.com>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Reg Clemens <reg@dwf.com>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, reg@deneb.dwf.com
Subject: Re: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard 
In-reply-to: <20060307120039.61649a89.rdunlap@xenotime.net> 
References: <200603070340.k273ev0A003594@deneb.dwf.com> 
 <1141703317.25487.142.camel@mindpipe> <200603070823.k278NE9o006674@deneb.dwf.com> <20060307081806.0af1d2c4.rdunlap@xenotime.net> <200603071820.k27IKSsm003595@deneb.dwf.com> <20060307104646.9b2e193d.rdunlap@xenotime.net> <200603071932.k27JW0UH003735@deneb.dwf.com> <20060307120039.61649a89.rdunlap@xenotime.net>
Comments: In-reply-to "Randy.Dunlap" <rdunlap@xenotime.net>
   message dated "Tue, 07 Mar 2006 12:00:39 -0800."
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1141762868_31810"
Date: Tue, 07 Mar 2006 13:22:16 -0700
From: Reg Clemens <reg@dwf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1141762868_31810
Content-Type: text/plain; charset=us-ascii


> Ditto.  Please send an lspci -v



--==_Exmh_1141762868_31810
Content-Type: text/plain ; name="ZZZZ"; charset=us-ascii
Content-Description: ZZZZ
Content-Disposition: attachment; filename="ZZZZ"

00:00.0 Host bridge: Intel Corporation 945G/P Memory Controller Hub (rev 02)
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation 945G/P PCI Express Graphics Port (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: 48000000-4cffffff
	Prefetchable memory behind bridge: 0000000040000000-0000000047f00000
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
	Subsystem: Intel Corporation: Unknown device 0202
	Flags: bus master, fast devsel, latency 0, IRQ 50
	Memory at 4d100000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: 4d200000-4d2fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Memory behind bridge: 4d300000-4d3fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Memory behind bridge: 4d400000-4d4fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, medium devsel, latency 0, IRQ 58
	I/O ports at 2080 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, medium devsel, latency 0, IRQ 225
	I/O ports at 2060 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, medium devsel, latency 0, IRQ 209
	I/O ports at 2040 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at 2020 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, medium devsel, latency 0, IRQ 58
	Memory at 4d104000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 4d000000-4d0fffff
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, medium devsel, latency 0, IRQ 209
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 20b0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 225
	I/O ports at 20c8 [size=8]
	I/O ports at 20e4 [size=4]
	I/O ports at 20c0 [size=8]
	I/O ports at 20e0 [size=4]
	I/O ports at 20a0 [size=16]
	Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
	Subsystem: Intel Corporation: Unknown device 544e
	Flags: medium devsel, IRQ 11
	I/O ports at 2000 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2) (prog-if 00 [VGA])
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at 48000000 (32-bit, non-prefetchable) [size=64M]
	Memory at 40000000 (64-bit, prefetchable) [size=128M]
	Memory at 4c000000 (64-bit, non-prefetchable) [size=16M]
	Expansion ROM at fffe0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

05:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 04)
	Flags: medium devsel, IRQ 50
	I/O ports at f800 [size=256]
	Memory at 3ff00000 (32-bit, non-prefetchable) [size=256]
	Memory at 3ff01000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at ffff0000 [disabled] [size=64K]

05:02.0 Multimedia audio controller: Creative Labs SB Audigy LS
	Subsystem: Creative Labs SB0410 SBLive! 24-bit
	Flags: bus master, medium devsel, latency 32, IRQ 209
	I/O ports at 1200 [size=32]
	Capabilities: [dc] Power Management version 2

05:03.0 Ethernet controller: D-Link System Inc Gigabit Ethernet Adapter (rev 11)
	Subsystem: D-Link System Inc DGE-530T Gigabit Ethernet Adapter
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 225
	Memory at 4d000000 (32-bit, non-prefetchable) [size=16K]
	I/O ports at 1000 [size=256]
	Expansion ROM at fffe0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data


--==_Exmh_1141762868_31810
Content-Type: text/plain; charset=us-ascii

                                        Reg.Clemens
                                        reg@dwf.com

--==_Exmh_1141762868_31810--


Im going to be away from the machine till this evening.
Got to go take a shower and go into the LAB.



