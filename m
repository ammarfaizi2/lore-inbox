Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbTIXV70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTIXV70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:59:26 -0400
Received: from h139-142-214-162.gtcust.grouptelecom.net ([139.142.214.162]:59916
	"EHLO smtp.atrium.ca") by vger.kernel.org with ESMTP
	id S261628AbTIXV7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:59:08 -0400
Message-id: <fc.00869573006145e8008695730061456b.614627@atrium.ca>
Date: Wed, 24 Sep 2003 17:01:21 -0500
Subject: Re: 2.6.0-test5-mm3 Promise SuperTrak SX6000 unrecognized
To: "Dave Poirier" <dave.poirier@atrium.ca>
Cc: linux-kernel@vger.kernel.org
From: "Dave Poirier" <dave.poirier@atrium.ca>
References: <fc.008695730061456b008695730061456b.6145b2@atrium.ca>
In-Reply-To: <fc.008695730061456b008695730061456b.6145b2@atrium.ca>
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_--00614627.006145e8.bb977e61"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----=_--00614627.006145e8.bb977e61
Content-type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

"Dave Poirier" <dave.poirier@atrium.ca> writes:
(snip)
>Find attached the `lspci -vxx` output.
(snip)




----=_--00614627.006145e8.bb977e61
Content-Type: text/plain; name="lspci.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80f2
	Flags: bus master, fast devsel, latency 0
	Memory at f8000000 (32-bit, prefetchable) =5Bsize=3D64M=5D
	Capabilities: =5Be4=5D =2309 =5B2106=5D
	Capabilities: =5Ba0=5D AGP version 3.0
00: 86 80 70 25 06 00 90 20 02 00 00 06 00 00 00 00
10: 08 00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 f2 80
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02) (prog-if 00 =
=5BNormal decode=5D)
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: e7700000-f76fffff
00: 86 80 71 25 07 01 a0 00 02 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 c0 c0 a0 22
20: 90 fe 90 fe 70 e7 60 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02) (prog-if =
00 =5BUHCI=5D)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at ef00 =5Bsize=3D32=5D
00: 86 80 d2 24 05 00 80 02 02 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ef 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02) (prog-if =
00 =5BUHCI=5D)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at ef20 =5Bsize=3D32=5D
00: 86 80 d4 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 ef 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02) (prog-if =
00 =5BUHCI=5D)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at ef40 =5Bsize=3D32=5D
00: 86 80 d7 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 ef 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 03 00 00

00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02) (prog-if =
00 =5BUHCI=5D)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at ef80 =5Bsize=3D32=5D
00: 86 80 de 24 05 00 80 02 02 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 ef 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02) (prog-if =
20)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at febffc00 (32-bit, non-prefetchable) =5Bsize=3D1K=5D
	Capabilities: =5B50=5D Power Management version 2
	Capabilities: =5B58=5D =230a =5B20a0=5D
00: 86 80 dd 24 06 01 90 02 02 20 03 0c 00 00 00 00
10: 00 fc bf fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 04 00 00

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev c2) (=
prog-if 00 =5BNormal decode=5D)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D03, sec-latency=3D64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: f7700000-f7efffff
00: 86 80 4e 24 07 01 80 00 c2 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 03 40 d0 d0 80 22
20: a0 fe a0 fe 70 f7 e0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
	Flags: bus master, medium devsel, latency 0
00: 86 80 d0 24 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02) (prog-if 8=
a =5BMaster SecP PriP=5D)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at fc00 =5Bsize=3D16=5D
	Memory at 80000000 (32-bit, non-prefetchable) =5Bdisabled=5D =5Bsize=3D1K=
=5D
00: 86 80 db 24 05 00 88 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 01 fc 00 00 00 00 00 80 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Flags: medium devsel, IRQ 17
	I/O ports at 0400 =5Bsize=3D32=5D
00: 86 80 d3 24 01 00 80 02 02 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 04 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-=
if 00 =5BVGA=5D)
	Subsystem: Unknown device 17af:2001
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 16
	Memory at e8000000 (32-bit, prefetchable) =5Bsize=3D128M=5D
	I/O ports at c000 =5Bsize=3D256=5D
	Memory at fe9f0000 (32-bit, non-prefetchable) =5Bsize=3D64K=5D
	Expansion ROM at fe9c0000 =5Bdisabled=5D =5Bsize=3D128K=5D
	Capabilities: =5B58=5D AGP version 2.0
	Capabilities: =5B50=5D Power Management version 2
00: 02 10 59 51 87 01 b0 02 00 00 00 03 04 40 00 00
10: 08 00 00 e8 01 c0 00 00 00 00 9f fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 af 17 01 20
30: 00 00 9c fe 58 00 00 00 00 00 00 00 0a 01 08 00

02:05.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev 12)=

	Subsystem: Asustek Computer, Inc.: Unknown device 80eb
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 22
	Memory at feaf8000 (32-bit, non-prefetchable) =5Bsize=3D16K=5D
	I/O ports at d800 =5Bsize=3D256=5D
	Capabilities: =5B48=5D Power Management version 2
	Capabilities: =5B50=5D Vital Product Data
00: b7 10 00 17 17 01 b0 02 12 00 00 02 04 40 00 00
10: 00 80 af fe 01 d8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 eb 80
30: 00 00 00 00 48 00 00 00 00 00 00 00 05 01 17 1f

02:0d.0 PCI bridge: Intel Corp.: Unknown device 0962 (rev 02) (prog-if 00 =
=5BNormal decode=5D)
	Flags: bus master, medium devsel, latency 64
	Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D64
00: 86 80 62 09 06 01 80 02 02 00 04 06 04 40 81 00
10: 00 00 00 00 00 00 00 00 02 03 03 40 f0 00 80 22
20: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 02 00

02:0d.1 Class ff00: Intel Corp.: Unknown device 1962 (rev 02) (prog-if 01)
	Subsystem: Promise Technology, Inc.: Unknown device 0000
	Flags: bus master, medium devsel, latency 64, IRQ 21
	Memory at f7800000 (32-bit, prefetchable) =5Bsize=3D4M=5D
	Expansion ROM at feae0000 =5Bdisabled=5D =5Bsize=3D64K=5D
00: 86 80 62 19 16 01 80 02 02 01 00 ff 04 40 80 00
10: 08 00 80 f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 5a 10 00 00
30: 00 00 ae fe 80 00 00 00 00 00 00 00 05 01 00 00


----=_--00614627.006145e8.bb977e61--
