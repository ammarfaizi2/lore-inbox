Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUGJAIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUGJAIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUGJAIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:08:41 -0400
Received: from pop.gmx.de ([213.165.64.20]:30357 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266028AbUGJAHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:07:25 -0400
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
Reply-To: warpy@gmx.de
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.7-mm7
Date: Sat, 10 Jul 2004 02:07:30 +0200
User-Agent: KMail/1.6.2
References: <20040708235025.5f8436b7.akpm@osdl.org> <200407091344.32938.warpy@gmx.de> <20040709221540.GB6284@kroah.com>
In-Reply-To: <20040709221540.GB6284@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CNz7A0uFc5ucIvd"
Message-Id: <200407100207.30109.warpy@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_CNz7A0uFc5ucIvd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> Do you have any USB devices plugged in?

Yes, 
Usb Keyboard, Usb Mouse and USB-2.0 Storage Device (Cypress Semiconductor)

I unplugged my USB devices at boot time 
and now makes it boot.

thanks

-- 
Michael Geithe

>^..^< 
Linux !? ;-) > Willkommen in der "besseren" Welt!

-

--Boundary-00=_CNz7A0uFc5ucIvd
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

 Jul 10 01:40:54 stargate kernel: Linux version 2.6.7-mm7 (root@stargate) (gcc-Version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 SMP Sat Jul 10 01:36:02 CEST 2004
Jul 10 01:40:54 stargate kernel: BIOS-provided physical RAM map:
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 00000000000d4000 - 00000000000de014 (reserved)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jul 10 01:40:54 stargate kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Jul 10 01:40:54 stargate kernel: 127MB HIGHMEM available.
Jul 10 01:40:54 stargate kernel: 896MB LOWMEM available.
Jul 10 01:40:54 stargate kernel: found SMP MP-table at 000fc0f0
Jul 10 01:40:54 stargate kernel: On node 0 totalpages: 262128
Jul 10 01:40:54 stargate kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul 10 01:40:54 stargate kernel:   Normal zone: 225280 pages, LIFO batch:16
Jul 10 01:40:54 stargate kernel:   HighMem zone: 32752 pages, LIFO batch:7
Jul 10 01:40:54 stargate kernel: DMI 2.3 present.
Jul 10 01:40:54 stargate kernel: ACPI: RSDP (v000 AMI                                       ) @ 0x000fa390
Jul 10 01:40:54 stargate kernel: ACPI: RSDT (v001 AMIINT INTEL875 0x00000010 MSFT 0x00000097) @ 0x3fff0000
Jul 10 01:40:54 stargate kernel: ACPI: FADT (v001 AMIINT INTEL875 0x00000011 MSFT 0x00000097) @ 0x3fff0030
Jul 10 01:40:54 stargate kernel: ACPI: MADT (v001 AMIINT INTEL875 0x00000009 MSFT 0x00000097) @ 0x3fff00c0
Jul 10 01:40:54 stargate kernel: ACPI: DSDT (v001  INTEL     I875 0x00001000 MSFT 0x0100000d) @ 0x00000000
Jul 10 01:40:54 stargate kernel: ACPI: Local APIC address 0xfee00000
Jul 10 01:40:54 stargate kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Jul 10 01:40:54 stargate kernel: Processor #0 15:2 APIC version 20
Jul 10 01:40:54 stargate kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jul 10 01:40:54 stargate kernel: Processor #1 15:2 APIC version 20
Jul 10 01:40:54 stargate kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jul 10 01:40:54 stargate kernel: IOAPIC[0]: Assigned apic_id 2
Jul 10 01:40:54 stargate kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jul 10 01:40:54 stargate kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jul 10 01:40:54 stargate kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jul 10 01:40:54 stargate kernel: ACPI: IRQ0 used by override.
Jul 10 01:40:54 stargate kernel: ACPI: IRQ2 used by override.
Jul 10 01:40:54 stargate kernel: ACPI: IRQ9 used by override.
Jul 10 01:40:54 stargate kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Jul 10 01:40:54 stargate kernel: Using ACPI (MADT) for SMP configuration information
Jul 10 01:40:54 stargate kernel: Built 1 zonelists
Jul 10 01:40:54 stargate kernel: Initializing CPU#0
Jul 10 01:40:54 stargate kernel: Kernel command line: root=/dev/hda1  video=vesafb:ypan,vram:16 vga=0x317
Jul 10 01:40:54 stargate kernel: CPU 0 irqstacks, hard=c03cf000 soft=c03cd000
Jul 10 01:40:54 stargate kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Jul 10 01:40:54 stargate kernel: Detected 2801.186 MHz processor.
Jul 10 01:40:54 stargate kernel: Using tsc for high-res timesource
Jul 10 01:40:54 stargate kernel: Console: colour dummy device 80x25
Jul 10 01:40:54 stargate kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Jul 10 01:40:54 stargate kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 10 01:40:54 stargate kernel: Memory: 1035148k/1048512k available (2037k kernel code, 12456k reserved, 645k data, 172k init, 131008k highmem)
Jul 10 01:40:54 stargate kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jul 10 01:40:54 stargate kernel: Calibrating delay loop... 5537.79 BogoMIPS
Jul 10 01:40:54 stargate kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Jul 10 01:40:54 stargate kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
Jul 10 01:40:54 stargate kernel: CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
Jul 10 01:40:54 stargate kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jul 10 01:40:54 stargate kernel: CPU: L2 cache: 512K
Jul 10 01:40:54 stargate kernel: CPU: Physical Processor ID: 0
Jul 10 01:40:54 stargate kernel: CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Jul 10 01:40:54 stargate kernel: Intel machine check architecture supported.
Jul 10 01:40:54 stargate kernel: Intel machine check reporting enabled on CPU#0.
Jul 10 01:40:54 stargate kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Jul 10 01:40:54 stargate kernel: CPU0: Thermal monitoring enabled
Jul 10 01:40:54 stargate kernel: Enabling fast FPU save and restore... done.
Jul 10 01:40:54 stargate kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 10 01:40:54 stargate kernel: Checking 'hlt' instruction... OK.
Jul 10 01:40:54 stargate kernel: CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Jul 10 01:40:54 stargate kernel: per-CPU timeslice cutoff: 1462.66 usecs.
Jul 10 01:40:54 stargate kernel: task migration cache decay timeout: 2 msecs.
Jul 10 01:40:54 stargate kernel: enabled ExtINT on CPU#0
Jul 10 01:40:54 stargate kernel: ESR value before enabling vector: 00000000
Jul 10 01:40:54 stargate kernel: ESR value after enabling vector: 00000000
Jul 10 01:40:54 stargate kernel: Booting processor 1/1 eip 2000
Jul 10 01:40:54 stargate kernel: CPU 1 irqstacks, hard=c03d0000 soft=c03ce000
Jul 10 01:40:54 stargate kernel: Initializing CPU#1
Jul 10 01:40:54 stargate kernel: masked ExtINT on CPU#1
Jul 10 01:40:54 stargate kernel: ESR value before enabling vector: 00000000
Jul 10 01:40:54 stargate kernel: ESR value after enabling vector: 00000000
Jul 10 01:40:54 stargate kernel: Calibrating delay loop... 5586.94 BogoMIPS
Jul 10 01:40:54 stargate kernel: CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
Jul 10 01:40:54 stargate kernel: CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
Jul 10 01:40:54 stargate kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jul 10 01:40:54 stargate kernel: CPU: L2 cache: 512K
Jul 10 01:40:54 stargate kernel: CPU: Physical Processor ID: 0
Jul 10 01:40:54 stargate kernel: CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Jul 10 01:40:54 stargate kernel: Intel machine check architecture supported.
Jul 10 01:40:54 stargate kernel: Intel machine check reporting enabled on CPU#1.
Jul 10 01:40:54 stargate kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Jul 10 01:40:54 stargate kernel: CPU1: Thermal monitoring enabled
Jul 10 01:40:54 stargate kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Jul 10 01:40:54 stargate kernel: Total of 2 processors activated (11124.73 BogoMIPS).
Jul 10 01:40:54 stargate kernel: ENABLING IO-APIC IRQs
Jul 10 01:40:54 stargate kernel: init IO_APIC IRQs
Jul 10 01:40:54 stargate kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jul 10 01:40:54 stargate kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jul 10 01:40:54 stargate kernel: Using local APIC timer interrupts.
Jul 10 01:40:54 stargate kernel: calibrating APIC timer ...
Jul 10 01:40:54 stargate kernel: ..... CPU clock speed is 2799.0697 MHz.
Jul 10 01:40:54 stargate kernel: ..... host bus clock speed is 199.0978 MHz.
Jul 10 01:40:54 stargate kernel: checking TSC synchronization across 2 CPUs: passed.
Jul 10 01:40:54 stargate kernel: Brought up 2 CPUs
Jul 10 01:40:54 stargate kernel: CPU0:  online
Jul 10 01:40:54 stargate kernel:  domain 0: span 3
Jul 10 01:40:54 stargate kernel:   groups: 1 2
Jul 10 01:40:54 stargate kernel:   domain 1: span 3
Jul 10 01:40:54 stargate kernel:    groups: 3
Jul 10 01:40:54 stargate kernel: CPU1:  online
Jul 10 01:40:54 stargate kernel:  domain 0: span 3
Jul 10 01:40:54 stargate kernel:   groups: 2 1
Jul 10 01:40:54 stargate kernel:   domain 1: span 3
Jul 10 01:40:54 stargate kernel:    groups: 3
Jul 10 01:40:54 stargate kernel: checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Jul 10 01:40:54 stargate kernel: Freeing initrd memory: 117k freed
Jul 10 01:40:54 stargate kernel: NET: Registered protocol family 16
Jul 10 01:40:54 stargate kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=2
Jul 10 01:40:54 stargate kernel: PCI: Using configuration type 1
Jul 10 01:40:54 stargate kernel: mtrr: v2.0 (20020519)
Jul 10 01:40:54 stargate kernel: ACPI: Subsystem revision 20040615
Jul 10 01:40:54 stargate kernel: ACPI: Interpreter enabled
Jul 10 01:40:54 stargate kernel: ACPI: Using IOAPIC for interrupt routing
Jul 10 01:40:54 stargate kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 10 01:40:54 stargate kernel: PCI: Probing PCI hardware (bus 00)
Jul 10 01:40:54 stargate kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Jul 10 01:40:54 stargate kernel: PCI: Transparent bridge - 0000:00:1e.0
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICHB._PRT]
Jul 10 01:40:54 stargate kernel: ACPI: Power Resource [URP1] (off)
Jul 10 01:40:54 stargate kernel: ACPI: Power Resource [URP2] (off)
Jul 10 01:40:54 stargate kernel: ACPI: Power Resource [FDDP] (off)
Jul 10 01:40:54 stargate kernel: ACPI: Power Resource [LPTP] (off)
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jul 10 01:40:54 stargate kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jul 10 01:40:54 stargate kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul 10 01:40:54 stargate kernel: SCSI subsystem initialized
Jul 10 01:40:54 stargate kernel: PCI: Using ACPI for IRQ routing
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 17
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 17
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:01.2[B] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:02.1[A] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
Jul 10 01:40:54 stargate kernel: number of MP IRQ sources: 15.
Jul 10 01:40:54 stargate kernel: number of IO-APIC #2 registers: 24.
Jul 10 01:40:54 stargate kernel: testing the IO APIC.......................
Jul 10 01:40:54 stargate kernel: IO APIC #2......
Jul 10 01:40:54 stargate kernel: .... register #00: 02000000
Jul 10 01:40:54 stargate kernel: .......    : physical APIC id: 02
Jul 10 01:40:54 stargate kernel: .......    : Delivery Type: 0
Jul 10 01:40:54 stargate kernel: .......    : LTS          : 0
Jul 10 01:40:54 stargate kernel: .... register #01: 00178020
Jul 10 01:40:54 stargate kernel: .......     : max redirection entries: 0017
Jul 10 01:40:54 stargate kernel: .......     : PRQ implemented: 1
Jul 10 01:40:54 stargate kernel: .......     : IO APIC version: 0020
Jul 10 01:40:54 stargate kernel: .... IRQ redirection table:
Jul 10 01:40:54 stargate kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jul 10 01:40:54 stargate kernel:  00 000 00  1    0    0   0   0    0    0    00
Jul 10 01:40:54 stargate kernel:  01 003 03  0    0    0   0   0    1    1    39
Jul 10 01:40:54 stargate kernel:  02 003 03  0    0    0   0   0    1    1    31
Jul 10 01:40:54 stargate kernel:  03 003 03  0    0    0   0   0    1    1    41
Jul 10 01:40:54 stargate kernel:  04 003 03  0    0    0   0   0    1    1    49
Jul 10 01:40:54 stargate kernel:  05 003 03  0    0    0   0   0    1    1    51
Jul 10 01:40:54 stargate kernel:  06 003 03  0    0    0   0   0    1    1    59
Jul 10 01:40:54 stargate kernel:  07 003 03  0    0    0   0   0    1    1    61
Jul 10 01:40:54 stargate kernel:  08 003 03  0    0    0   0   0    1    1    69
Jul 10 01:40:54 stargate kernel:  09 003 03  0    1    0   0   0    1    1    71
Jul 10 01:40:54 stargate kernel:  0a 003 03  0    0    0   0   0    1    1    79
Jul 10 01:40:54 stargate kernel:  0b 003 03  0    0    0   0   0    1    1    81
Jul 10 01:40:54 stargate kernel:  0c 003 03  0    0    0   0   0    1    1    89
Jul 10 01:40:54 stargate kernel:  0d 003 03  0    0    0   0   0    1    1    91
Jul 10 01:40:54 stargate kernel:  0e 003 03  0    0    0   0   0    1    1    99
Jul 10 01:40:54 stargate kernel:  0f 003 03  0    0    0   0   0    1    1    A1
Jul 10 01:40:54 stargate kernel:  10 003 03  1    1    0   1   0    1    1    A9
Jul 10 01:40:54 stargate kernel:  11 003 03  1    1    0   1   0    1    1    C9
Jul 10 01:40:54 stargate kernel:  12 003 03  1    1    0   1   0    1    1    B9
Jul 10 01:40:54 stargate kernel:  13 003 03  1    1    0   1   0    1    1    B1
Jul 10 01:40:54 stargate kernel:  14 003 03  1    1    0   1   0    1    1    D1
Jul 10 01:40:54 stargate kernel:  15 000 00  1    0    0   0   0    0    0    00
Jul 10 01:40:54 stargate kernel:  16 000 00  1    0    0   0   0    0    0    00
Jul 10 01:40:54 stargate kernel:  17 003 03  1    1    0   1   0    1    1    C1
Jul 10 01:40:54 stargate kernel: IRQ to pin mappings:
Jul 10 01:40:54 stargate kernel: IRQ0 -> 0:2
Jul 10 01:40:54 stargate kernel: IRQ1 -> 0:1
Jul 10 01:40:54 stargate kernel: IRQ3 -> 0:3
Jul 10 01:40:54 stargate kernel: IRQ4 -> 0:4
Jul 10 01:40:54 stargate kernel: IRQ5 -> 0:5
Jul 10 01:40:54 stargate kernel: IRQ6 -> 0:6
Jul 10 01:40:54 stargate kernel: IRQ7 -> 0:7
Jul 10 01:40:54 stargate kernel: IRQ8 -> 0:8
Jul 10 01:40:54 stargate kernel: IRQ9 -> 0:9
Jul 10 01:40:54 stargate kernel: IRQ10 -> 0:10
Jul 10 01:40:54 stargate kernel: IRQ11 -> 0:11
Jul 10 01:40:54 stargate kernel: IRQ12 -> 0:12
Jul 10 01:40:54 stargate kernel: IRQ13 -> 0:13
Jul 10 01:40:54 stargate kernel: IRQ14 -> 0:14
Jul 10 01:40:54 stargate kernel: IRQ15 -> 0:15
Jul 10 01:40:54 stargate kernel: IRQ16 -> 0:16
Jul 10 01:40:54 stargate kernel: IRQ17 -> 0:17
Jul 10 01:40:54 stargate kernel: IRQ18 -> 0:18
Jul 10 01:40:54 stargate kernel: IRQ19 -> 0:19
Jul 10 01:40:54 stargate kernel: IRQ20 -> 0:20
Jul 10 01:40:54 stargate kernel: IRQ23 -> 0:23
Jul 10 01:40:54 stargate kernel: .................................... done.
Jul 10 01:40:54 stargate kernel: vesafb: framebuffer at 0xe8000000, mapped to 0xf8880000, size 16384k
Jul 10 01:40:54 stargate kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=1
Jul 10 01:40:54 stargate kernel: vesafb: protected mode interface info at c000:e9d0
Jul 10 01:40:54 stargate kernel: vesafb: pmi: set display start = c00cea15, set palette = c00cea9a
Jul 10 01:40:54 stargate kernel: vesafb: pmi: ports = b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03 
Jul 10 01:40:54 stargate kernel: vesafb: scrolling: ypan using protected mode interface, yres_virtual=8192
Jul 10 01:40:54 stargate kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Jul 10 01:40:54 stargate kernel: fb0: VESA VGA frame buffer device
Jul 10 01:40:54 stargate kernel: Machine check exception polling timer started.
Jul 10 01:40:54 stargate kernel: Starting balanced_irq
Jul 10 01:40:54 stargate kernel: highmem bounce pool size: 64 pages
Jul 10 01:40:54 stargate kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Jul 10 01:40:54 stargate kernel: ACPI: Processor [CPU1] (supports C1, 8 throttling states)
Jul 10 01:40:54 stargate kernel: ACPI: Processor [CPU2] (supports C1, 8 throttling states)
Jul 10 01:40:54 stargate kernel: Console: switching to colour frame buffer device 128x48
Jul 10 01:40:54 stargate kernel: Real Time Clock Driver v1.12
Jul 10 01:40:54 stargate kernel: Using anticipatory io scheduler
Jul 10 01:40:54 stargate kernel: Floppy drive(s): fd0 is 1.44M
Jul 10 01:40:54 stargate kernel: FDC 0 is a post-1991 82077
Jul 10 01:40:54 stargate kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jul 10 01:40:54 stargate kernel: loop: loaded (max 8 devices)
Jul 10 01:40:54 stargate kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
Jul 10 01:40:54 stargate kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
Jul 10 01:40:54 stargate kernel: eth0: 0000:02:08.0, 00:0C:76:27:61:10, IRQ 20.
Jul 10 01:40:54 stargate kernel:   Board assembly 000000-000, Physical connectors present: RJ45
Jul 10 01:40:54 stargate kernel:   Primary interface chip i82555 PHY #1.
Jul 10 01:40:54 stargate kernel:   General self-test: passed.
Jul 10 01:40:54 stargate kernel:   Serial sub-system self-test: passed.
Jul 10 01:40:54 stargate kernel:   Internal registers self-test: passed.
Jul 10 01:40:54 stargate kernel:   ROM checksum self-test: passed (0xed626fe2).
Jul 10 01:40:54 stargate kernel: Linux video capture interface: v1.00
Jul 10 01:40:54 stargate kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul 10 01:40:54 stargate kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul 10 01:40:54 stargate kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Jul 10 01:40:54 stargate kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: ICH5: chipset revision 2
Jul 10 01:40:54 stargate kernel: ICH5: not 100%% native mode: will probe irqs later
Jul 10 01:40:54 stargate kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
Jul 10 01:40:54 stargate kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Jul 10 01:40:54 stargate kernel: hda: WDC WD600AB-00CDB0, ATA DISK drive
Jul 10 01:40:54 stargate kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 10 01:40:54 stargate kernel: hdc: ST340015A, ATA DISK drive
Jul 10 01:40:54 stargate kernel: hdd: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
Jul 10 01:40:54 stargate kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 10 01:40:54 stargate kernel: hda: max request size: 128KiB
Jul 10 01:40:54 stargate kernel: hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jul 10 01:40:54 stargate kernel: hda: cache flushes supported
Jul 10 01:40:54 stargate kernel:  hda: hda1
Jul 10 01:40:54 stargate kernel: hdc: max request size: 128KiB
Jul 10 01:40:54 stargate kernel: hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jul 10 01:40:54 stargate kernel: hdc: cache flushes supported
Jul 10 01:40:54 stargate kernel:  hdc: hdc1 hdc2 hdc3
Jul 10 01:40:54 stargate kernel: hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Jul 10 01:40:54 stargate kernel: Uniform CD-ROM driver Revision: 3.20
Jul 10 01:40:54 stargate kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 10 01:40:54 stargate kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 10 01:40:54 stargate kernel: mice: PS/2 mouse device common for all mice
Jul 10 01:40:54 stargate kernel: i2c /dev entries driver
Jul 10 01:40:54 stargate kernel: NET: Registered protocol family 2
Jul 10 01:40:54 stargate kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Jul 10 01:40:54 stargate kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jul 10 01:40:54 stargate kernel: NET: Registered protocol family 1
Jul 10 01:40:54 stargate kernel: NET: Registered protocol family 17
Jul 10 01:40:54 stargate kernel: RAMDISK: Couldn't find valid RAM disk image starting at 0.
Jul 10 01:40:54 stargate kernel: ReiserFS: hda1: found reiserfs format "3.6" with standard journal
Jul 10 01:40:54 stargate kernel: ReiserFS: hda1: using ordered data mode
Jul 10 01:40:54 stargate kernel: ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul 10 01:40:54 stargate kernel: ReiserFS: hda1: checking transaction log (hda1)
Jul 10 01:40:54 stargate kernel: ReiserFS: hda1: replayed 6 transactions in 0 seconds
Jul 10 01:40:54 stargate kernel: ReiserFS: hda1: Using r5 hash to sort names
Jul 10 01:40:54 stargate kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Jul 10 01:40:54 stargate kernel: Freeing unused kernel memory: 172k freed
Jul 10 01:40:54 stargate kernel: Adding 847720k swap on /dev/hdc3.  Priority:-1 extents:1
Jul 10 01:40:54 stargate kernel: nvidia: module license 'NVIDIA' taints kernel.
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul 10 01:40:54 stargate kernel: NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6106  Wed Jun 23 08:14:01 PDT 2004
Jul 10 01:40:54 stargate kernel: ReiserFS: hdc2: found reiserfs format "3.6" with standard journal
Jul 10 01:40:54 stargate kernel: ReiserFS: hdc2: using ordered data mode
Jul 10 01:40:54 stargate kernel: ReiserFS: hdc2: journal params: device hdc2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Jul 10 01:40:54 stargate kernel: ReiserFS: hdc2: checking transaction log (hdc2)
Jul 10 01:40:54 stargate kernel: ReiserFS: hdc2: replayed 1 transactions in 0 seconds
Jul 10 01:40:54 stargate kernel: ReiserFS: hdc2: Using r5 hash to sort names
Jul 10 01:40:54 stargate kernel: usbcore: registered new driver usbfs
Jul 10 01:40:54 stargate kernel: usbcore: registered new driver hub
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 17
Jul 10 01:40:54 stargate kernel: USB Universal Host Controller Interface driver v2.2
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Jul 10 01:40:54 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.0: irq 16, io base 0000e000
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Jul 10 01:40:54 stargate kernel: hub 1-0:1.0: USB hub found
Jul 10 01:40:54 stargate kernel: hub 1-0:1.0: 2 ports detected
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Jul 10 01:40:54 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0000e400
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
Jul 10 01:40:54 stargate kernel: hub 2-0:1.0: USB hub found
Jul 10 01:40:54 stargate kernel: hub 2-0:1.0: 2 ports detected
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Jul 10 01:40:54 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0000e800
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
Jul 10 01:40:54 stargate kernel: hub 3-0:1.0: USB hub found
Jul 10 01:40:54 stargate kernel: hub 3-0:1.0: 2 ports detected
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Jul 10 01:40:54 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.3: irq 16, io base 0000ec00
Jul 10 01:40:54 stargate kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
Jul 10 01:40:54 stargate kernel: hub 4-0:1.0: USB hub found
Jul 10 01:40:54 stargate kernel: hub 4-0:1.0: 2 ports detected
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
Jul 10 01:40:54 stargate kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Jul 10 01:40:54 stargate kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jul 10 01:40:54 stargate kernel: ehci_hcd 0000:00:1d.7: irq 23, pci mem f8878c00
Jul 10 01:40:54 stargate kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
Jul 10 01:40:54 stargate kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jul 10 01:40:54 stargate kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Jul 10 01:40:54 stargate kernel: hub 5-0:1.0: USB hub found
Jul 10 01:40:54 stargate kernel: hub 5-0:1.0: 8 ports detected
Jul 10 01:40:54 stargate kernel: ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:01.2[B] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[feaff000-feaff7ff]  Max Packet=[2048]
Jul 10 01:40:54 stargate kernel: bttv: driver version 0.9.15 loaded
Jul 10 01:40:54 stargate kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Jul 10 01:40:54 stargate kernel: bttv: Bt8xx card found (0).
Jul 10 01:40:54 stargate kernel: ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 18 (level, low) -> IRQ 18
Jul 10 01:40:54 stargate kernel: bttv0: Bt878 (rev 17) at 0000:02:02.0, irq: 18, latency: 32, mmio: 0xf7efe000
Jul 10 01:40:54 stargate kernel: bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
Jul 10 01:40:54 stargate kernel: bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
Jul 10 01:40:54 stargate kernel: bttv0: gpio: en=00000000, out=00000000 in=00ff67ff [init]
Jul 10 01:40:54 stargate kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Jul 10 01:40:54 stargate kernel: bttv0: miro: id=25 tuner=1 radio=no stereo=no
Jul 10 01:40:54 stargate kernel: bttv0: using tuner=1
Jul 10 01:40:54 stargate kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Jul 10 01:40:54 stargate kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Jul 10 01:40:54 stargate kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Jul 10 01:40:54 stargate kernel: bttv0: registered device video0
Jul 10 01:40:54 stargate kernel: bttv0: registered device vbi0
Jul 10 01:40:54 stargate kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Jul 10 01:40:54 stargate kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0151028a1f]
Jul 10 01:40:54 stargate kernel: hdd: CHECK for good STATUS
Jul 10 01:40:57 stargate rpc.statd[8033]: Version 1.0.6 Starting
Jul 10 01:40:57 stargate cron[8075]: (CRON) STARTUP (fork ok) 
Jul 10 01:40:57 stargate init: Activating demand-procedures for 'A'
Jul 10 01:42:03 stargate kernel: usb 2-1: new low speed USB device using address 2
Jul 10 01:42:03 stargate kernel: usbcore: registered new driver hiddev
Jul 10 01:42:03 stargate kernel: input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-1
Jul 10 01:42:03 stargate kernel: input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0000:00:1d.1-1
Jul 10 01:42:03 stargate kernel: usbcore: registered new driver usbhid
Jul 10 01:42:03 stargate kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jul 10 01:42:11 stargate kernel: usb 3-1: new low speed USB device using address 2
Jul 10 01:42:11 stargate kernel: input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1d.2-1
Jul 10 01:45:00 stargate CRON[8699]: (root) CMD (test -x /usr/sbin/run-crons && /usr/sbin/run-crons ) 
Jul 10 02:00:00 stargate CRON[8942]: (root) CMD (rm -f /var/spool/cron/lastrun/cron.hourly) 
Jul 10 02:00:00 stargate CRON[8944]: (root) CMD (test -x /usr/sbin/run-crons && /usr/sbin/run-crons ) 
Jul 10 02:00:46 stargate kernel: usb 5-1: new high speed USB device using address 4
Jul 10 02:00:46 stargate kernel: Initializing USB Mass Storage driver...
Jul 10 02:00:46 stargate kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Jul 10 02:00:46 stargate kernel:   Vendor: SAMSUNG   Model: SV1296A           Rev:  0 0
Jul 10 02:00:46 stargate kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jul 10 02:00:46 stargate kernel: SCSI device sda: 25238304 512-byte hdwr sectors (12922 MB)
Jul 10 02:00:46 stargate kernel: sda: assuming drive cache: write through
Jul 10 02:00:46 stargate kernel:  sda: sda1
Jul 10 02:00:46 stargate kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jul 10 02:00:46 stargate kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Jul 10 02:00:46 stargate kernel: USB Mass Storage device found at 4
Jul 10 02:00:46 stargate kernel: usbcore: registered new driver usb-storage
Jul 10 02:00:46 stargate kernel: USB Mass Storage support registered.
Jul 10 02:00:47 stargate scsi.agent[8999]: disk at /devices/pci0000:00/0000:00:1d.7/usb5/5-1/5-1:1.0/host0/0:0:0:0

--Boundary-00=_CNz7A0uFc5ucIvd--
