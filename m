Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbSKGLGm>; Thu, 7 Nov 2002 06:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSKGLGm>; Thu, 7 Nov 2002 06:06:42 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:37845 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266478AbSKGLGl>; Thu, 7 Nov 2002 06:06:41 -0500
Message-Id: <4.3.2.7.2.20021107120832.00b4eae0@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 07 Nov 2002 12:13:32 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: 2.4.20 rc1 ACPI
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Anybody have any idea about following ACPI messages ?
	MB Intel D845PESVL /latest BIOS

Inspecting /boot/System.map-2.4.20
Loaded 17297 symbols from /boot/System.map-2.4.20.
Symbols match kernel version 2.4.20.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.20 (root@roglinux) (gcc version 3.2) #2 Thu Nov 7 
11:37:51 CET
2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
<4> BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
<4> BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
<5>511MB LOWMEM available.
<4>On node 0 totalpages: 130880
<4>zone(0): 4096 pages.
<4>zone(1): 126784 pages.
<4>zone(2): 0 pages.
<4>Kernel command line: root=/dev/sda2   vga=normal
<4>Found and enabled local APIC!
<6>Initializing CPU#0
<4>Detected 2400.161 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 4784.12 BogoMIPS
<6>Memory: 515316k/523520k available (1352k kernel code, 7816k reserved, 
286k data,
268k init, 0k highmem)
<6>Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
<6>Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
<4>Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
<6>CPU: L1 I cache: 0K, L1 D cache: 8K
<6>CPU: L2 cache: 512K
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 2400.2736 MHz.
<4>..... host bus clock speed is 133.3483 MHz.
<4>cpu: 0, clocks: 1333483, slice: 666741
<4>CPU0<T0:1333472,T1:666720,D:11,S:666741,C:1333483>
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<6>PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<4>Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
<6>PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
<6>PCI: Found IRQ 15 for device 00:1f.1
<6>PCI: Sharing IRQ 15 with 00:1d.2
<6>PCI: Sharing IRQ 15 with 02:05.0
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>apm: BIOS not found.
<4>Starting kswapd
<4>    ACPI-0202: *** Warning: Invalid table signature ASF! found
<4>    ACPI-0095: *** Error: Acpi_load_tables: Error getting required 
tables (DSDT/F
ADT/FACS): AE_BAD_SIGNATURE
<4>    ACPI-0116: *** Error: Acpi_load_tables: Could not load tables: 
AE_BAD_SIGNATU
RE
<3>ACPI: System description table load failed

	Cheers

	Margit Schubert-While 

