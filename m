Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTEYSMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 14:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTEYSMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 14:12:08 -0400
Received: from www.wwns.com ([209.149.59.66]:8417 "EHLO wwns.wwns.com")
	by vger.kernel.org with ESMTP id S261825AbTEYSMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 14:12:06 -0400
From: "David R. Wilson" <david@wwns.com>
Message-Id: <200305251831.h4PIVPg07012@wwns.wwns.com>
Subject: Re: Asrock K7S8X Motherboard kernel problem
To: vojtech@suse.cz, mikpe@csd.uu.se, linux-kernel@vger.kernel.org
Date: Sun, 25 May 2003 13:31:25 -0500 (CDT)
In-Reply-To: <200305251752.h4PHqw206618@wwns.wwns.com> from "David R. Wilson" at May 25, 2003 12:52:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



More info from lspci -v

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0746 (rev 02)
	Subsystem: Unknown device 1849:0746
	Flags: bus master, medium devsel, latency 0
	Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 3.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202 (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
	Memory behind bridge: cdd00000-cfefffff
	Prefetchable memory behind bridge: bd900000-cdbfffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 25)
	Flags: bus master, medium devsel, latency 0

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: Unknown device 1849:5513
	Flags: bus master, medium devsel, latency 128
	I/O ports at ff00 [size=16]

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
	Subsystem: Unknown device 434d:4961
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at dc00 [size=256]
	I/O ports at d800 [size=128]
	Capabilities: [48] Power Management version 2

00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1849:7001
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at cfffd000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Unknown device 1849:7001
	Flags: bus master, medium devsel, latency 32, IRQ 3
	Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0 (prog-if 20 [EHCI])
	Subsystem: Unknown device 1849:7001
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at cffff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 90)
	Subsystem: Unknown device 1849:8201
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at d400 [size=256]
	Memory at cfffc000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fffe0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] (rev a3) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
	Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Memory at cdb80000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at cfee0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0




-- 
David R. Wilson  WB4LHO
World Wide Network Services
Nashville, Tennessee USA
david@wwns.com

