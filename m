Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUCaF3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 00:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUCaF3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 00:29:31 -0500
Received: from pool-162-83-134-229.ny5030.east.verizon.net ([162.83.134.229]:32990
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S261742AbUCaF3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 00:29:00 -0500
Subject: Re: 2.6.5-rc3-mm1
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9R7C7zZJqP/jYi2UcYgI"
Message-Id: <1080710943.4050.7.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 (Slackware Linux)
Date: Wed, 31 Mar 2004 00:29:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9R7C7zZJqP/jYi2UcYgI
Content-Type: multipart/mixed; boundary="=-CHOR5FdwfdpPWlhc3pmg"


--=-CHOR5FdwfdpPWlhc3pmg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

This shows up on NForce2 board.

Linux version 2.6.5-rc3-mm1 (root@blaze) (gcc version 3.3.3) #1 Tue Mar
30 14:40:20 EST 2004

from dmesg:

ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
mapped 4G/4G trampoline to fffeb000.
Initializing CPU#0
Kernel command line: auto BOOT_IMAGE=3DSlackware_2.6 ro root=3D801
rootflags=3Dquota video=3Dvesafb:ywrap,mtrr
CPU 0 irqstacks, hard=3D02443000 soft=3D02442000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2205.498 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 1035716k/1048512k available (2316k kernel code, 12052k reserved,
810k data, 180k init, 0k highmem)
Calibrating delay loop... 4358.14 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an
initrd
Freeing initrd memory: 78k freed
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 3200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,
2-23 not connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2204.0623 MHz.
..... host bus clock speed is 400.0840 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfaee0, last bus=3D3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs *17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs 16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xa9 -> IRQ 23 Mode:1
Active:0)
00:00:01[A] -> 2-23 -> IRQ 23
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb1 -> IRQ 20 Mode:1
Active:0)
00:00:02[A] -> 2-20 -> IRQ 20
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xb9 -> IRQ 22 Mode:1
Active:0)
00:00:02[B] -> 2-22 -> IRQ 22
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc1 -> IRQ 21 Mode:1
Active:0)
00:00:02[C] -> 2-21 -> IRQ 21
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 21
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1
Active:0)
00:01:06[A] -> 2-18 -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1
Active:0)
00:01:06[B] -> 2-19 -> IRQ 19
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xd9 -> IRQ 16 Mode:1
Active:0)
00:01:06[C] -> 2-16 -> IRQ 16
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xe1 -> IRQ 17 Mode:1
Active:0)
00:01:06[D] -> 2-17 -> IRQ 17
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  1    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   0   0    1    1    D9
 11 001 01  1    1    0   0   0    1    1    E1
 12 001 01  1    1    0   0   0    1    1    C9
 13 001 01  1    1    0   0   0    1    1    D1
 14 001 01  1    1    0   0   0    1    1    B1
 15 001 01  1    1    0   0   0    1    1    C1
 16 001 01  1    1    0   0   0    1    1    B9
 17 001 01  1    1    0   0   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even
'acpi=3Doff'
vesafb: framebuffer at 0xc0000000, mapped to 0x42808000, size 16384k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D9
vesafb: protected mode interface info at c000:581c
vesafb: pmi: set display start =3D 020c58b0, set palette =3D 020c58fc
vesafb: pmi: ports =3D c010 c016 c054 c038 c03c c05c c000 c004 c0b0 c0b2
c0b4
vesafb: scrolling: ywrap using protected mode interface,
yres_virtual=3D8192
vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
SGI XFS with ACLs, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
bootsplash 3.1.4-2004/02/19: looking for picture.... found (1024x768,
80505 bytes, v2).
Console: switching to colour frame buffer device 105x34
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
hda: WDC WD300BB-00AUA1, ATA DISK drive
hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 58631231 sectors (30019 MB)
        native  capacity is 58633344 sectors (30020 MB)
hda: 58631231 sectors (30019 MB) w/2048KiB Cache, CHS=3D58165/16/63
 hda: hda1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs
=20
(scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
  Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
libata version 1.02 loaded.
Found Controller: IT8212 UDMA/ATA133 RAID Controller
Device 0 is IDE
Channel[0] BM-DMA at 0x9800-0x9807
Channel[1] BM-DMA at 0x9808-0x980F
scsi1 : ITE RAIDExpress133
  Vendor: ITE       Model: IT8212F           Rev: 1.3
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sdb: 468883200 512-byte hdwr sectors (240068 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.13 2004-Mar-09, 3 devices found
Please report your BIOS at http://linux.dell.com/edd/results.html
RAMDISK: Couldn't find valid RAM disk image starting at 0.
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding 248968k swap on /dev/sda7.  Priority:-1 extents:1
XFS mounting filesystem sda2
Ending clean XFS mount for filesystem: sda2
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
Supermount version 2.0.4 for kernel 2.6
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k2
Copyright (c) 1999-2004 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1172 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[22]
MMIO=3D[e6084000-e60847ff]  Max Packet=3D[2048]
amd74xx: no version for "cleanup_module" found: kernel tainted.
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
NFORCE2: port 0x01f0 already claimed by ide0
NFORCE2: port 0x0170 already claimed by ide1
NFORCE2: neither IDE port enabled (BIOS)
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49394 usecs
intel8x0: clocking to 47419
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:04.0
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 21, pci mem 438cd000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 20, pci mem 438fd000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 22, pci mem 438ff000
Badness in get_phy_reg at drivers/ieee1394/ohci1394.c:238
Call Trace:
 [<4381310e>] get_phy_reg+0x10e/0x120 [ohci1394]
 [<43813f3c>] ohci_devctl+0x5c/0x5d0 [ohci1394]
 [<02114a54>] delay_pmtmr+0x14/0x20
 [<43816058>] ohci_irq_handler+0x588/0x830 [ohci1394]
 [<0212827f>] do_timer+0xdf/0xf0
 [<0210ac2a>] handle_IRQ_event+0x3a/0x70
 [<0210b005>] do_IRQ+0xd5/0x1b0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<43813193>] set_phy_reg+0x73/0x120 [ohci1394]
 [<022d2c67>] hcd_submit_urb+0x137/0x160
 [<438d1d40>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<43813f56>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<438da3b7>] csr1212_fill_cache+0x97/0x100 [ieee1394]
 [<438d1d40>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<438cf1a5>] hpsb_reset_bus+0x35/0x40 [ieee1394]
 [<438d1df4>] delayed_reset_bus+0xb4/0xd0 [ieee1394]
 [<02128094>] run_timer_softirq+0xd4/0x1d0
 [<02130563>] rcu_process_callbacks+0x83/0x100
 [<02123dbd>] __do_softirq+0x7d/0x80
 [<0210b92e>] do_softirq+0x4e/0x60
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<0210b08b>] do_IRQ+0x15b/0x1b0
=20
Badness in set_phy_reg at drivers/ieee1394/ohci1394.c:267
Call Trace:
 [<43813230>] set_phy_reg+0x110/0x120 [ohci1394]
 [<43813f56>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<02114a54>] delay_pmtmr+0x14/0x20
 [<43816058>] ohci_irq_handler+0x588/0x830 [ohci1394]
 [<0212827f>] do_timer+0xdf/0xf0
 [<0210ac2a>] handle_IRQ_event+0x3a/0x70
 [<0210b005>] do_IRQ+0xd5/0x1b0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<43813193>] set_phy_reg+0x73/0x120 [ohci1394]
 [<022d2c67>] hcd_submit_urb+0x137/0x160
 [<438d1d40>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<43813f56>] ohci_devctl+0x76/0x5d0 [ohci1394]
 [<438da3b7>] csr1212_fill_cache+0x97/0x100 [ieee1394]
 [<438d1d40>] delayed_reset_bus+0x0/0xd0 [ieee1394]
 [<438cf1a5>] hpsb_reset_bus+0x35/0x40 [ieee1394]
 [<438d1df4>] delayed_reset_bus+0xb4/0xd0 [ieee1394]
 [<02128094>] run_timer_softirq+0xd4/0x1d0
 [<02130563>] rcu_process_callbacks+0x83/0x100
 [<02123dbd>] __do_softirq+0x7d/0x80
 [<0210b92e>] do_softirq+0x4e/0x60
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 [<0210b08b>] do_IRQ+0x15b/0x1b0
=20
ohci1394: fw-host0: SelfID received outside of bus reset sequence
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xb0000000
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[8a1cc7ffff0020ed]
ip1394: $Rev: 1175 $ Ben Collins <bcollins@debian.org>
ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
usb 2-1: new full speed USB device using address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
usb 2-2: new low speed USB device using address 3
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(TM)] on usb-0000:00:02.0-2
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 2-1.1: new low speed USB device using address 4
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on
usb-0000:00:02.0-1.1
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on
usb-0000:00:02.0-1.1
usb 3-1: new full speed USB device using address 2
nfs warning: mount version older than kernel
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
Real Time Clock Driver v1.12
eth0: no IPv6 routers present
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies,
Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 930 MBytes.
[fglrx] module loaded - fglrx 3.7.0 [Dec 18 2003] on minor 0
[fglrx] AGP detected, AgpState   =3D 0x1f00421b (hardware caps of chipset)
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:03:00.0 into 8x mode
[fglrx] AGP enabled,  AgpCommand =3D 0x1f004312 (selected caps)
[fglrx] free  AGP =3D 256126976
[fglrx] max   AGP =3D 256126976
[fglrx] free  LFB =3D 116391936
[fglrx] max   LFB =3D 116391936
[fglrx] free  Inv =3D 0
[fglrx] max   Inv =3D 0
[fglrx] total Inv =3D 0
[fglrx] total TIM =3D 0
[fglrx] total FB  =3D 0
[fglrx] total AGP =3D 65536
inserting floppy driver for 2.6.5-rc3-mm1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
end_request: I/O error, dev fd0, sector 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
sr: unaligned transfer
FAT: unable to read boot sector
ide-floppy driver 0.99.newide
hdc: No disk in drive

Attached is /proc/config.gz

Thanks,

Paul B.

--=-CHOR5FdwfdpPWlhc3pmg
Content-Disposition: attachment; filename=config.gz
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64

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


--=-CHOR5FdwfdpPWlhc3pmg--

--=-9R7C7zZJqP/jYi2UcYgI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAalcfv0+bfGBjm98RAkyvAJ4tLl3f3x4S5coWEgSg2GruvdoOHgCgjob/
sBU57zpbioYCWZHkWVv1f4U=
=szY0
-----END PGP SIGNATURE-----

--=-9R7C7zZJqP/jYi2UcYgI--
