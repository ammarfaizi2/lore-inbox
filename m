Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSJEC6N>; Fri, 4 Oct 2002 22:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSJEC6N>; Fri, 4 Oct 2002 22:58:13 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:836 "HELO
	laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S261972AbSJEC6H>; Fri, 4 Oct 2002 22:58:07 -0400
From: brian@worldcontrol.com
Date: Fri, 4 Oct 2002 20:03:34 -0700
To: linux-kernel@vger.kernel.org
Subject: Dumps during boot 2.5.40-ac3
Message-ID: <20021005030334.GA1453@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux version 2.5.40-ac3 (root@top.worldcontrol.com) (gcc version 2.95.3 20010315 (release)) #3 Fri Oct 4 19:53:43 PDT 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ef0000 (usable)
 BIOS-e820: 0000000017ef0000 - 0000000017eff000 (ACPI data)
 BIOS-e820: 0000000017eff000 - 0000000017f00000 (ACPI NVS)
 BIOS-e820: 0000000017f00000 - 0000000018000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
384MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 98304
  DMA zone: 4096 pages
  Normal zone: 94208 pages
  HighMem zone: 0 pages
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7700
ACPI: RSDT (v001 SONY   K5       01540.00000) @ 0x17ef9d89
ACPI: FADT (v001 SONY   K5       01540.00000) @ 0x17efee4c
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x17efeec0
ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x17efeee8
ACPI: DSDT (v001  SONY  K5       01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Sony Vaio laptop detected.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda2 resume=/dev/hda3
Initializing CPU#0
Detected 900.158 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1773.56 BogoMIPS
Memory: 385344k/393216k available (1698k kernel code, 7420k reserved, 774k data, 88k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0383f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1c7f9ff 00000000 00000000
CPU: AMD mobile AMD Duron(tm) stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfd7cd, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
ACPI: Subsystem revision 20020918
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
ACPI: Power Resource [PCR0] (off)
ACPI: Power Resource [PCR1] (off)
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Capability LSM initialized
Applying VIA southbridge workaround.
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
ACPI: Thermal Zone [THRM] (54 C)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Real Time Clock Driver v1.11
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 322M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 128M @ 0xf0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xf0000000 128MB
MTRR: setting reg 2
[drm] Initialized radeon 1.6.0 20020828 on minor 0
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1c40-0x1c47, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c48-0x1c4f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4018GAP, ATA DISK drive
hda: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
d7ecdeb4 c0113644 c02b07a0 c02b5950 0000055e 00000000 c012f9c3 c02b5950 
       0000055e c03d39b4 c03d397c d7ffd380 00000000 c021fa97 c13caea0 000001d0 
       c03d397c c03d396c d7ffd380 00000000 00000000 c021fb2d c03d397c c03d397c 
Call Trace:
 [<c0113644>]__might_sleep+0x54/0x60
 [<c012f9c3>]kmem_cache_alloc+0x23/0x100
 [<c021fa97>]blk_init_free_list+0x47/0xd0
 [<c021fb2d>]blk_init_queue+0xd/0xf0
 [<c022fd08>]ide_init_queue+0x28/0x70
 [<c0236390>]do_ide_request+0x0/0x20
 [<c022ffe8>]init_irq+0x298/0x360
 [<c0230346>]hwif_init+0x106/0x250
 [<c022fc2c>]probe_hwif_init+0x1c/0x70
 [<c024046d>]ide_setup_pci_device+0x3d/0x70
 [<c022ecc3>]via_init_one+0x33/0x40
 [<c010508a>]init+0x2a/0x180
 [<c0105060>]init+0x0/0x180
 [<c01054d5>]kernel_thread_helper+0x5/0x10

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
d7ecdeb4 c0113644 c02b07a0 c02b5950 0000055e 00000000 c012f9c3 c02b5950 
       0000055e c03d3f8c c03d3f54 d7ffd440 00000000 c021fa97 c13caea0 000001d0 
       c03d3f54 c03d3f44 d7ffd440 00000000 00000000 c021fb2d c03d3f54 c03d3f54 
Call Trace:
 [<c0113644>]__might_sleep+0x54/0x60
 [<c012f9c3>]kmem_cache_alloc+0x23/0x100
 [<c021fa97>]blk_init_free_list+0x47/0xd0
 [<c021fb2d>]blk_init_queue+0xd/0xf0
 [<c022fd08>]ide_init_queue+0x28/0x70
 [<c0236390>]do_ide_request+0x0/0x20
 [<c022ffe8>]init_irq+0x298/0x360
 [<c0230346>]hwif_init+0x106/0x250
 [<c022fc2c>]probe_hwif_init+0x1c/0x70
 [<c0240491>]ide_setup_pci_device+0x61/0x70
 [<c022ecc3>]via_init_one+0x33/0x40
 [<c010508a>]init+0x2a/0x180
 [<c0105060>]init+0x0/0x180
 [<c01054d5>]kernel_thread_helper+0x5/0x10

ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78140160 sectors (40008 MB), CHS=4864/255/63, UDMA(100)
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0808, PCI irq9
Socket status: 30000010
Yenta IRQ list 0808, PCI irq10
Socket status: 30000006
Resume Machine: resuming from /dev/hda3
Resuming from device ide0(3,3)
Resume Machine: This is normal swap space
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 88k freed
Adding 779144k swap on /dev/hda3.  Priority:-1 extents:1
usb.c: registered new driver usbfs
usb.c: registered new driver hub
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: DMA disabled
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xd88b7800, 08:00:46:2e:b2:18, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
cs: IO port probe 0x1000-0x17ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
hermes.c: 4 Jul 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0001:0006:0004
eth1: Looks like a Lucent/Agere firmware version 6.04
eth1: Ad-hoc demo mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:E0:63:82:45:DA
eth1: Station name "HERMES I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f
eth1: New link status: Connected (0001)
Via 686a audio driver 1.9.1
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
via82cxxx: board #1 at 0x1000, IRQ 5
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
MTRR: setting reg 3
MTRR: setting reg 3
MTRR: setting reg 3

-- 
Brian Litzinger
