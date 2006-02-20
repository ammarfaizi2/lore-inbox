Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWBTRo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWBTRo1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWBTRo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:44:26 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:7176 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161091AbWBTRoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:44:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=uTLTYA/ssu/KFjUcPumySjR1bPb+Rx583uc7CIsjgweyEFOIUA2rBDmjcdvBc01EQrd+JXJ14q7yykzV4dkEbUs9yS+0uwC+qt/ORDxWDpB4gIyOaaOGnf8Nfwvbq22KZCVIUtzgR9JRj3Kf7UNw7LdBPkydl5GAkDKTCZVoGD0=
Message-ID: <b637ec0b0602200944u6e2020efh319ca78cfd03c78d@mail.gmail.com>
Date: Mon, 20 Feb 2006 18:44:22 +0100
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1140457017.26526.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9686_15196515.1140457462191"
References: <1140445182.26526.1.camel@localhost.localdomain>
	 <b637ec0b0602200742j5780bfcck75f9090c91b8760f@mail.gmail.com>
	 <1140457017.26526.26.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_9686_15196515.1140457462191
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

QXR0YWNoZWQuCkZhYmlvCgpPbiAyLzIwLzA2LCBBbGFuIENveCA8YWxhbkBseG9yZ3VrLnVrdXUu
b3JnLnVrPiB3cm90ZToKPiBPbiBMbHUsIDIwMDYtMDItMjAgYXQgMTY6NDIgKzAxMDAsIEZhYmlv
IENvbW9sbGkgd3JvdGU6Cj4gPiBIaSBBbGFuLgo+ID4gRG9lcyB0aGlzIHZlcnNpb24gYWRkcmVz
cyB0aGUgaXNzdWUgSSBwb2ludGVkIG91dCBzb21lIGRheXMgYWdvIChJQ0g0Cj4gPiBpZGVudGlm
aWVkIGFzIG9ubHkgVURNQS82NiBjYXBhYmxlKT8KPgo+IEknbSBzdGlsbCBzY3JhdGNoaW5nIG15
IGhlYWQgb3ZlciB0aGF0IG9uZS4gSXRzIG9uIHRoZSB0b2RvIGxpc3QuCj4gQWN0dWFsbHkgb25l
IHRob3VnaHQgLSBjYW4geW91IHNlbmQgbWUgYW4gbHNwY2kgLXZ4eAo+Cj4KPiBBbGFuCj4KPgo=
------=_Part_9686_15196515.1140457462191
Content-Type: text/plain; name=lspci_output.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejx2wrh6
Content-Disposition: attachment; filename="lspci_output.txt"

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, fast devsel, latency 0
	Memory at <unassigned> (32-bit, prefetchable)
	Capabilities: [40] Vendor Specific Information
00: 86 80 80 35 06 01 90 30 02 00 00 06 00 00 80 00
10: 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, fast devsel, latency 0
00: 86 80 84 35 06 00 80 00 02 00 80 08 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, fast devsel, latency 0
00: 86 80 85 35 06 00 80 00 02 00 80 08 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, fast devsel, latency 0, IRQ 6
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at 1800 [size=8]
	Capabilities: [d0] Power Management version 1
00: 86 80 82 35 07 00 98 00 02 00 00 03 00 00 80 00
10: 08 00 00 e8 00 00 00 e0 01 18 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 06 01 00 00

00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, fast devsel, latency 0
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Memory at e0080000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1
00: 86 80 82 35 07 00 90 00 02 00 80 03 00 00 80 00
10: 08 00 00 f0 00 00 08 e0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00

00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at 1820 [size=32]
00: 86 80 c2 24 05 00 80 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 06 01 00 00

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at 1840 [size=32]
00: 86 80 c4 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 06 02 00 00

00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at 1860 [size=32]
00: 86 80 c7 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 18 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 06 03 00 00

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 10
	Memory at e0100000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port
00: 86 80 cd 24 06 01 90 02 03 20 03 0c 00 00 00 00
10: 00 00 10 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 04 00 00

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: e0200000-e05fffff
	Prefetchable memory behind bridge: 30000000-32ffffff
00: 86 80 48 24 07 01 80 88 83 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 40 30 30 80 22
20: 20 e0 50 e0 00 30 f0 32 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 03)
	Flags: bus master, medium devsel, latency 0
00: 86 80 cc 24 0f 00 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 6
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1810 [size=16]
	Memory at 33000000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 ca 24 07 00 80 02 03 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 11 18 00 00 00 00 00 33 00 00 00 00 25 10 64 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: medium devsel, IRQ 10
	I/O ports at 1880 [size=32]
00: 86 80 c3 24 01 00 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 18 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at 1c00 [size=256]
	I/O ports at 18c0 [size=64]
	Memory at e0100c00 (32-bit, non-prefetchable) [size=512]
	Memory at e0100800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
00: 86 80 c5 24 07 00 90 02 03 00 01 04 00 00 00 00
10: 01 1c 00 00 c1 18 00 00 00 0c 10 e0 00 08 10 e0
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: medium devsel, IRQ 10
	I/O ports at 2400 [size=256]
	I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
00: 86 80 c6 24 01 00 90 02 03 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 02 00 00

02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, fast devsel, latency 64, IRQ 6
	Memory at e0204000 (32-bit, non-prefetchable) [size=8K]
	[virtual] Expansion ROM at 32000000 [disabled] [size=16K]
	Capabilities: [40] Power Management version 2
00: e4 14 01 44 06 01 10 08 01 00 00 02 00 40 00 00
10: 00 40 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 06 01 00 00

02:04.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation Unknown device 2701
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at e0208000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: 86 80 20 42 16 01 90 02 05 00 80 02 08 40 00 00
10: 00 80 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 01 27
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 03 18

02:06.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at e0209000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 30000000-31fff000 (prefetchable)
	Memory window 1: 34000000-35fff000
	I/O window 0: 00003000-000030ff
	I/O window 1: 00003400-000034ff
	16-bit legacy interface ports at 0001
00: 4c 10 31 80 07 00 10 02 00 00 07 06 10 a8 82 00
10: 00 90 20 e0 a0 00 00 02 02 03 06 b0 00 00 00 30
20: 00 f0 ff 31 00 00 00 34 00 f0 ff 35 00 30 00 00
30: fc 30 00 00 00 34 00 00 fc 34 00 00 0a 01 c0 05
40: 25 10 64 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:06.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host Controller (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at e020a000 (32-bit, non-prefetchable) [size=2K]
	Memory at e0200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
00: 4c 10 32 80 16 01 10 02 00 10 00 0c 08 40 80 00
10: 00 a0 20 e0 00 00 20 e0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 03 04

02:06.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
	Subsystem: Acer Incorporated [ALI] Unknown device 0064
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at e0206000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [44] Power Management version 2
00: 4c 10 33 80 06 01 10 02 00 00 80 01 08 40 80 00
10: 00 60 20 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 25 10 64 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 07 04


------=_Part_9686_15196515.1140457462191--
