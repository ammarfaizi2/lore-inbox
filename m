Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQKWDxZ>; Wed, 22 Nov 2000 22:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131179AbQKWDxP>; Wed, 22 Nov 2000 22:53:15 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:35079 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129514AbQKWDxJ>; Wed, 22 Nov 2000 22:53:09 -0500
Date: Wed, 22 Nov 2000 21:23:05 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac2
Message-ID: <20001122212305.M2918@wire.cadcamlab.org>
In-Reply-To: <E13yeMn-0006HW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13yeMn-0006HW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 22, 2000 at 06:11:30PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Alan Cox]
> Changes in 2.4.0test11ac2
> o	Work arounds for broken Dell laptop APM		(me)
> 	| If you have an Inspiron 5000e please send 
> 	| me the dmesg of this kernel booting. Thanks

Inspiron 5000, is this close enough?

Linux version 2.4.0-test11-ac2 (peter@kendall) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #3 Wed Nov 22 21:09:37 CST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000015000 @ 00000000000eb000 (reserved)
 BIOS-e820: 0000000003ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000fc00 @ 0000000003ff0000 (ACPI data)
 BIOS-e820: 0000000000000400 @ 0000000003fffc00 (ACPI NVS)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f800 for 4096 bytes.
On node 0 totalpages: 16368
zone(0): 4096 pages.
zone(1): 12272 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01111000)
Kernel command line: vga=normal noinitrd BOOT_IMAGE=linux root=/dev/hda2 vga=1
Initializing CPU#0
Detected 448.060 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 894.57 BogoMIPS
Memory: 62436k/65472k available (1056k kernel code, 2648k reserved, 80k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 11 for device 00:04.0
PCI: The same IRQ used for device 00:04.1
PCI: The same IRQ used for device 01:00.0
PCI: Cannot allocate resource region 4 of device 00:07.1
  got res[1090:109f] for resource 4 of Intel Corporation 82371AB PIIX4 IDE
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1090-0x1097, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1098-0x109f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHK2120AT, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-7002B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 23579136 sectors (12073 MB) w/512KiB Cache, CHS=1559/240/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
LVM version 0.8final  by Heinz Mauelshagen  (15/02/2000)
lvm -- Driver successfully initialized
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0698, PCI irq11
Socket status: 30000068
Yenta IRQ list 0698, PCI irq11
Socket status: 30000006
cs: cb_alloc(bus 6): vendor 0x10b7, device 0x5257
  got res[3400:347f] for resource 0 of PCI device 10b7:5257
  got res[11000000:1100007f] for resource 1 of PCI device 10b7:5257
  got res[11000080:110000ff] for resource 2 of PCI device 10b7:5257
  got res[10c00000:10c1ffff] for resource 6 of PCI device 10b7:5257
PCI: Enabling device 06:00.0 (0000 -> 0003)
PCI: Found IRQ 11 for device 06:00.0
PCI: The same IRQ used for device 00:04.0
PCI: The same IRQ used for device 00:04.1
PCI: The same IRQ used for device 01:00.0
call_usermodehelper[/sbin/hotplug]: no root fs
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding Swap: 204792k swap-space (priority 0)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
