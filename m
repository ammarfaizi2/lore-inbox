Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269712AbTGOVNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269729AbTGOVNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:13:23 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:46720
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S269712AbTGOVNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:13:02 -0400
From: "jds" <jds@soltis.cc>
To: Greg KH <greg@kroah.com>, "Trever L. Adams" <tadams-lists@myrealbox.com>,
       David Brownell <david-b@pacbell.net>
Cc: arjanv@redhat.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [More Info] Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms installed)
Date: Tue, 15 Jul 2003 14:55:18 -0600
Message-Id: <20030715204357.M97188@soltis.cc>
In-Reply-To: <20030715210240.GA5345@kroah.com>
References: <1058196612.3353.2.camel@aurora.localdomain> <3F12FF53.7060708@pobox.com> <1058210139.5981.6.camel@laptop.fenrus.com> <1058217601.4441.1.camel@aurora.localdomain> <1058299838.3358.4.camel@aurora.localdomain> <20030715210240.GA5345@kroah.com>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arjanv:

   I run test kernel 2.6.0-test1 rpms the problems is the mouse not working, i
have symboles modules Unknown, ACPI not working, anex the messages:



Jul 14 20:03:40 toshiba kernel: Linux version 2.6.0-0.test1.1.24
(bhcompile@porky.devel.redhat.com) (gcc version 3.3 20030623 (Red Hat Linux
3.3-12)) #1 Mon Jul 14 10:32:51 EDT 2003
Jul 14 20:03:40 toshiba kernel: Video mode to be used for restore is f00
Jul 14 20:03:40 toshiba kernel: BIOS-provided physical RAM map:
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 00000000000e8000 -
00000000000e8640 (reserved)
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 00000000000e8640 -
00000000000e8840 (ACPI NVS)
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 00000000000e8840 -
00000000000ec000 (reserved)
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 0000000000100000 -
000000001ffe0000 (usable)
Jul 14 20:03:40 toshiba keytable: Loading keymap:
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 000000001ffe0000 -
000000001fff0000 (ACPI data)
Jul 14 20:03:40 toshiba keytable:
Jul 14 20:03:40 toshiba kernel:  BIOS-e820: 000000001fff0000 -
0000000020000000 (reserved)
Jul 14 20:03:41 toshiba keytable: Loading system font:
Jul 14 20:03:41 toshiba kernel:  BIOS-e820: 00000000fff80000 -
0000000100000000 (reserved)
Jul 14 20:03:41 toshiba keytable:
Jul 14 20:03:41 toshiba kernel: 0MB HIGHMEM available.
Jul 14 20:03:41 toshiba rc: Starting keytable:  succeeded
Jul 14 20:03:41 toshiba kernel: 511MB LOWMEM available.
Jul 14 20:03:41 toshiba kernel: On node 0 totalpages: 131040
Jul 14 20:03:41 toshiba random: Initializing random number generator:  succeeded
Jul 14 20:03:41 toshiba kernel:   DMA zone: 4096 pages, LIFO batch:1
Jul 14 20:03:41 toshiba kernel:   Normal zone: 126944 pages, LIFO batch:16
Jul 14 20:03:41 toshiba pcmcia: Starting PCMCIA services:
Jul 14 20:03:41 toshiba kernel:   HighMem zone: 0 pages, LIFO batch:1
Jul 14 20:03:41 toshiba kernel: ACPI: RSDP (v000 TOSHIB                     )
@ 0x000f4fd0
Jul 14 20:03:41 toshiba kernel: ACPI: RSDT (v001 TOSHIB 750      00151.02068)
@ 0x1ffe0000
Jul 14 20:03:41 toshiba kernel: ACPI: FADT (v001 TOSHIB 750      00151.02068)
@ 0x1ffe0054
Jul 14 20:03:41 toshiba kernel: ACPI: DSDT (v001 TOSHIB 8100     08192.01556)
@ 0x00000000
Jul 14 20:03:41 toshiba kernel: ACPI: BIOS passes blacklist
Jul 14 20:03:41 toshiba kernel: Building zonelist for node : 0
Jul 14 20:03:41 toshiba kernel: Kernel command line: ro root=LABEL=/
Jul 14 20:03:41 toshiba kernel: Initializing CPU#0
Jul 14 20:03:41 toshiba /sbin/hotplug: no runnable
/etc/hotplug/pcmcia_socket.agent is installed
Jul 14 20:03:41 toshiba /sbin/hotplug: no runnable
/etc/hotplug/pcmcia_socket.agent is installed
Jul 14 20:03:41 toshiba kernel: PID hash table entries: 2048 (order 11: 16384
bytes)
Jul 14 20:03:41 toshiba kernel: Detected 846.923 MHz processor.
Jul 14 20:03:41 toshiba kernel: Console: colour VGA+ 80x25
Jul 14 20:03:41 toshiba kernel: Calibrating delay loop... 1675.26 BogoMIPS
Jul 14 20:03:41 toshiba kernel: Memory: 515292k/524160k available (1656k
kernel code, 8100k reserved, 694k data, 160k init, 0k highmem)
Jul 14 20:03:41 toshiba kernel: Security Scaffold v1.0.0 initialized
Jul 14 20:03:41 toshiba kernel: Capability LSM initialized
Jul 14 20:03:41 toshiba kernel: Dentry cache hash table entries: 65536 (order:
6, 262144 bytes)
Jul 14 20:03:41 toshiba kernel: Inode-cache hash table entries: 32768 (order:
5, 131072 bytes)
Jul 14 20:03:41 toshiba kernel: Mount-cache hash table entries: 512 (order: 0,
4096 bytes)
Jul 14 20:03:41 toshiba kernel: -> /dev
Jul 14 20:03:41 toshiba kernel: -> /dev/console
Jul 14 20:03:41 toshiba kernel: -> /root
Jul 14 20:03:42 toshiba kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 14 20:03:42 toshiba kernel: CPU: L2 cache: 256K
Jul 14 20:03:42 toshiba kernel: Intel machine check architecture supported.
Jul 14 20:03:42 toshiba kernel: Intel machine check reporting enabled on CPU#0.
Jul 14 20:03:42 toshiba kernel: CPU: Intel Pentium III (Coppermine) stepping 06
Jul 14 20:03:42 toshiba kernel: Enabling fast FPU save and restore... done.
Jul 14 20:03:42 toshiba kernel: Enabling unmasked SIMD FPU exception
support... done.
Jul 14 20:03:42 toshiba kernel: Checking 'hlt' instruction... OK.
Jul 14 20:03:42 toshiba kernel: POSIX conformance testing by UNIFIX
Jul 14 20:03:42 toshiba kernel: Initializing RT netlink socket
Jul 14 20:03:42 toshiba kernel: PCI: PCI BIOS revision 2.10 entry at 0xfee03,
last bus=21
Jul 14 20:03:42 toshiba kernel: PCI: Using configuration type 1
Jul 14 20:03:42 toshiba kernel: mtrr: v2.0 (20020519)
Jul 14 20:03:42 toshiba kernel: BIO: pool of 256 setup, 15Kb (60 bytes/bio)
Jul 14 20:03:42 toshiba kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Jul 14 20:03:42 toshiba kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Jul 14 20:03:42 toshiba kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Jul 14 20:03:42 toshiba kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Jul 14 20:03:42 toshiba pcmcia:  cardmgr.
Jul 14 20:03:39 toshiba network: Setting network parameters:  succeeded
Jul 14 20:03:42 toshiba cardmgr[964]: starting, version is 3.1.31
Jul 14 20:03:42 toshiba /etc/hotplug/net.agent: NET add event not supported
Jul 14 20:03:42 toshiba kernel: biovec pool[4]: 128 bvecs: 256 entries (1536
bytes)
Jul 14 20:03:42 toshiba /etc/hotplug/pci.agent: ... no modules for PCI slot
0000:02:00.1
Jul 14 20:03:42 toshiba /etc/hotplug/pci.agent: Setup xircom_cb for PCI slot
0000:02:00.0
Jul 14 20:03:42 toshiba rc: Starting pcmcia:  succeeded
Jul 14 20:03:39 toshiba network: Bringing up loopback interface:  succeeded
Jul 14 20:03:42 toshiba cardmgr[964]: watching 2 sockets
Jul 14 20:03:42 toshiba kernel: biovec pool[5]: 256 bvecs: 256 entries (3072
bytes)
Jul 14 20:03:43 toshiba kernel: ACPI: Subsystem revision 20030619
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.LNKA._STA] (Node dffd1578),
AE_NOT_EXIST
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.LNKB._STA] (Node dffd1418),
AE_NOT_EXIST
Jul 14 20:03:43 toshiba cardmgr[964]: Card Services release does not match
Jul 14 20:03:43 toshiba devlabel: devlabel service started/restarted
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.LNKC._STA] (Node dffd12b8),
AE_NOT_EXIST
Jul 14 20:03:43 toshiba netfs: Mounting other filesystems:  succeeded
Jul 14 20:03:43 toshiba cardmgr[964]: socket 0: CardBus hotplug device
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.LNKD._STA] (Node dffd1b7c),
AE_NOT_EXIST
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node c15689c4), AE_NOT_EXIST
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.PCI0.FNC0.COM_._STA] (Node c1568d8c), AE_NOT_EXIST
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.PCI0.FNC0.PRT_._STA] (Node c15673ec), AE_NOT_EXIST
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.PCI0.FNC0.PRT1._STA] (Node c15672b8), AE_NOT_EXIST
Jul 14 20:03:43 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.PCI0.FNC0.PCC0._STA] (Node c15676d8), AE_NOT_EXIST
Jul 14 20:03:43 toshiba kernel: ACPI: Interpreter enabled
Jul 14 20:03:43 toshiba kernel: ACPI: Using PIC for interrupt routing
Jul 14 20:03:44 toshiba kernel:     ACPI-0109: *** Error: No object was
returned from [\_SB_.LNKE._PRS] (Node dffd19f0),
AE_NOT_EXIST
Jul 14 20:03:44 toshiba kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 14 20:03:44 toshiba kernel: PCI: Probing PCI hardware (bus 00)
Jul 14 20:03:44 toshiba kernel: ACPI: Power Resource [PIHD] (on)
Jul 14 20:03:44 toshiba kernel: ACPI: Power Resource [PMHD] (on)
Jul 14 20:03:44 toshiba kernel: ACPI: Power Resource [PFAN] (off)
Jul 14 20:03:44 toshiba kernel: Linux Plug and Play Support v0.96 (c) Adam Belay
Jul 14 20:03:44 toshiba kernel: ACPI: No IRQ known for interrupt pin D of
device 0000:00:05.2
Jul 14 20:03:44 toshiba kernel: ACPI: No IRQ known for interrupt pin A of
device 0000:00:07.0
Jul 14 20:03:44 toshiba kernel: ACPI: No IRQ known for interrupt pin A of
device 0000:00:09.0
Jul 14 20:03:44 toshiba kernel: ACPI: No IRQ known for interrupt pin A of
device 0000:00:0b.0 - using IRQ 255
Jul 14 20:03:44 toshiba kernel: ACPI: No IRQ known for interrupt pin B of
device 0000:00:0b.1 - using IRQ 255
Jul 14 20:03:44 toshiba kernel: ACPI: No IRQ known for interrupt pin A of
device 0000:00:0c.0
Jul 14 20:03:44 toshiba kernel: ACPI: No IRQ known for interrupt pin A of
device 0000:01:00.0
Jul 14 20:03:44 toshiba kernel: PCI: Using ACPI for IRQ routing
Jul 14 20:03:44 toshiba kernel: PCI: if you experience problems, try using
option 'pci=noacpi' or even 'acpi=off'
Jul 14 20:03:44 toshiba kernel: pty: 2048 Unix98 ptys configured
Jul 14 20:03:44 toshiba kernel: apm: BIOS version 1.2 Flags 0x02 (Driver
version 1.16ac)
Jul 14 20:03:44 toshiba kernel: apm: overridden by ACPI.
Jul 14 20:03:44 toshiba kernel: Enabling SEP on CPU 0
Jul 14 20:03:44 toshiba autofs: automount startup succeeded
Jul 14 20:03:44 toshiba kernel: Total HugeTLB memory allocated, 0
Jul 14 20:03:44 toshiba kernel: VFS: Disk quotas dquot_6.5.1
Jul 14 20:03:44 toshiba kernel: Initializing Cryptographic API
Jul 14 20:03:44 toshiba kernel: Limiting direct PCI/PCI transfers.
Jul 14 20:03:44 toshiba kernel: isapnp: Scanning for PnP cards...
Jul 14 20:03:44 toshiba kernel: isapnp: No Plug & Play device found
Jul 14 20:03:44 toshiba kernel: Real Time Clock Driver v1.11
Jul 14 20:03:44 toshiba kernel: Serial: 8250/16550 driver $Revision: 1.90 $
IRQ sharing enabled
Jul 14 20:03:45 toshiba kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul 14 20:03:45 toshiba kernel: RAMDISK driver initialized: 16 RAM disks of
8192K size 1024 blocksize
Jul 14 20:03:45 toshiba sshd:  succeeded
Jul 14 20:03:45 toshiba kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
Jul 14 20:03:45 toshiba kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Jul 14 20:03:45 toshiba kernel: PIIX4: IDE controller at PCI slot 0000:00:05.1
Jul 14 20:03:45 toshiba kernel: PIIX4: chipset revision 1
Jul 14 20:03:45 toshiba kernel: PIIX4: not 100%% native mode: will probe irqs
later
Jul 14 20:03:45 toshiba kernel:     ide0: BM-DMA at 0xfff0-0xfff7, BIOS
settings: hda:DMA, hdb:pio
Jul 14 20:03:45 toshiba kernel:     ide1: BM-DMA at 0xfff8-0xffff, BIOS
settings: hdc:DMA, hdd:pio
Jul 14 20:03:46 toshiba kernel: hda: TOSHIBA MK2016GAP, ATA DISK drive
Jul 14 20:03:46 toshiba kernel: anticipatory scheduling elevator
Jul 14 20:03:46 toshiba kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 14 20:03:46 toshiba kernel: hdc: TOSHIBA DVD-ROM SD-C2402, ATAPI
CD/DVD-ROM drive
Jul 14 20:03:46 toshiba kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 14 20:03:46 toshiba kernel: hda: max request size: 128KiB
Jul 14 20:03:46 toshiba kernel: hda: host protected area => 1
Jul 14 20:03:46 toshiba kernel: hda: 39070080 sectors (20004 MB),
CHS=38760/16/63, UDMA(33)
Jul 14 20:03:46 toshiba kernel:  hda: hda1 hda2 hda3
Jul 14 20:03:46 toshiba kernel: ide-floppy driver 0.99.newide
Jul 14 20:03:46 toshiba kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 14 20:03:46 toshiba kernel: input: AT Set 2 keyboard on isa0060/serio0
Jul 14 20:03:46 toshiba kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul 14 20:03:46 toshiba kernel: md: md driver 0.90.0 MAX_MD_DEVS=256,
MD_SB_DISKS=27
Jul 14 20:03:46 toshiba kernel: NET4: Frame Diverter 0.46
Jul 14 20:03:47 toshiba kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 14 20:03:47 toshiba kernel: IP: routing cache hash table of 4096 buckets,
32Kbytes
Jul 14 20:03:47 toshiba kernel: TCP: Hash tables configured (established 32768
bind 65536)
Jul 14 20:03:47 toshiba kernel: Linux IP multicast router 0.06 plus PIM-SM
Jul 14 20:03:47 toshiba kernel: Initializing IPsec netlink socket
Jul 14 20:03:47 toshiba kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Jul 14 20:03:47 toshiba kernel: md: Autodetecting RAID arrays.
Jul 14 20:03:47 toshiba kernel: md: autorun ...
Jul 14 20:03:47 toshiba kernel: md: ... autorun DONE.
Jul 14 20:03:47 toshiba kernel: RAMDISK: Compressed image found at block 0
Jul 14 20:03:47 toshiba kernel: Freeing initrd memory: 168k freed
Jul 14 20:03:47 toshiba kernel: VFS: Mounted root (ext2 filesystem).
Jul 14 20:03:47 toshiba kernel: Journalled Block Device driver loaded
Jul 14 20:03:47 toshiba kernel: kjournald starting.  Commit interval 5 seconds
Jul 14 20:03:47 toshiba kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Jul 14 20:03:47 toshiba kernel: Freeing unused kernel memory: 160k freed
Jul 14 20:03:47 toshiba kernel: drivers/usb/core/usb.c: registered new driver
usbfs
Jul 14 20:03:47 toshiba kernel: drivers/usb/core/usb.c: registered new driver hub
Jul 14 20:03:47 toshiba kernel: drivers/usb/core/usb.c: registered new driver
hiddev
Jul 14 20:03:47 toshiba kernel: drivers/usb/core/usb.c: registered new driver hid
Jul 14 20:03:47 toshiba kernel: drivers/usb/input/hid-core.c: v2.0:USB HID
core driver
Jul 14 20:03:47 toshiba kernel: mice: PS/2 mouse device common for all mice
Jul 14 20:03:47 toshiba kernel: EXT3 FS on hda2, internal journal
Jul 14 20:03:47 toshiba kernel: Adding 538168k swap on /dev/hda3.  Priority:-1
extents:1
Jul 14 20:03:47 toshiba kernel: kudzu: numerical sysctl 1 23 is obsolete.
Jul 14 20:03:47 toshiba kernel: parport0: PC-style at 0x378 (0x778)
[PCSPP,TRISTATE]
Jul 14 20:03:47 toshiba kernel: parport0: irq 7 detected
Jul 14 20:03:47 toshiba kernel: inserting floppy driver for 2.6.0-0.test1.1.24
Jul 14 20:03:47 toshiba kernel: Floppy drive(s): fd0 is 1.44M
Jul 14 20:03:47 toshiba kernel: FDC 0 is a post-1991 82077
Jul 14 20:03:47 toshiba kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 14 20:03:47 toshiba kernel: Linux Kernel Card Services 3.1.22
Jul 14 20:03:47 toshiba kernel:   options:  [pci] [cardbus] [pm]
Jul 14 20:03:47 toshiba kernel: PCI: Enabling device 0000:00:0b.0 (0000 -> 0002)
Jul 14 20:03:47 toshiba kernel: ACPI: No IRQ known for interrupt pin A of
device 0000:00:0b.0 - using IRQ 255
Jul 14 20:03:47 toshiba kernel: Yenta IRQ list 04b0, PCI irq0
Jul 14 20:03:47 toshiba kernel: Socket status: 30000020
Jul 14 20:03:47 toshiba kernel: PCI: Enabling device 0000:00:0b.1 (0000 -> 0002)
Jul 14 20:03:47 toshiba kernel: ACPI: No IRQ known for interrupt pin B of
device 0000:00:0b.1 - using IRQ 255
Jul 14 20:03:47 toshiba kernel: Yenta IRQ list 04b0, PCI irq0
Jul 14 20:03:47 toshiba kernel: Socket status: 30000007
Jul 14 20:03:47 toshiba kernel: PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
Jul 14 20:03:47 toshiba kernel: ACPI: No IRQ known for interrupt pin A of
device 0000:02:00.0
Jul 14 20:03:47 toshiba kernel: eth0: Xircom cardbus revision 3 at irq 0
Jul 14 20:03:47 toshiba kernel: PCI: Enabling device 0000:02:00.1 (0000 -> 0003)
Jul 14 20:03:48 toshiba kernel: ACPI: No IRQ known for interrupt pin A of
device 0000:02:00.1
Jul 14 20:03:48 toshiba kernel: ttyS1 at I/O 0x1080 (irq = 0) is a 16550A
Jul 14 20:03:48 toshiba xinetd[1568]: xinetd Version 2.3.11 started with
libwrap loadavg options compiled in.
Jul 14 20:03:48 toshiba xinetd[1568]: Started working: 0 available services
Jul 14 20:03:49 toshiba xinetd: xinetd startup succeeded
Jul 14 20:03:49 toshiba vsftpd: true startup succeeded
Jul 14 20:03:51 toshiba sendmail: sendmail startup succeeded
Jul 14 20:03:51 toshiba sendmail: sm-client startup succeeded
Jul 14 20:03:51 toshiba gpm: gpm startup succeeded
Jul 14 20:03:52 toshiba crond: crond startup succeeded
Jul 14 20:03:56 toshiba kernel: lp0: using parport0 (polling).
Jul 14 20:03:56 toshiba kernel: lp0: console ready
Jul 14 20:03:56 toshiba modprobe: FATAL: Module serial not found.
Jul 14 20:03:57 toshiba last message repeated 27 times
Jul 14 20:03:57 toshiba modprobe: FATAL: Module char_major_188 not found.
Jul 14 20:03:57 toshiba last message repeated 15 times
Jul 14 20:03:58 toshiba cups: cupsd startup succeeded
Jul 14 20:03:59 toshiba xfs: xfs startup succeeded
Jul 14 20:03:59 toshiba atd: atd startup succeeded
Jul 14 20:03:59 toshiba rcd: rcd startup succeeded
Jul 14 20:03:59 toshiba xfs: ignoring font path element
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable)
Jul 14 20:04:00 toshiba rcd[1792]: Red Carpet Daemon 1.4.4
Jul 14 20:04:00 toshiba rcd[1792]: Copyright (C) 2000-2003 Ximian Inc.
Jul 14 20:04:00 toshiba rcd[1792]: Start time: Mon Jul 14 20:04:00 2003
Jul 14 20:04:00 toshiba rcd[1792]: Loading system packages
Jul 14 20:04:02 toshiba gdm[1845]: gdm_server_spawn: Could not open logfile
for display :0!
Jul 14 20:04:02 toshiba modprobe: FATAL: Module char_major_10_134 not found.


Jul 14 20:40:23 toshiba kernel: generic_serial: Unknown symbol cli
Jul 14 20:40:23 toshiba kernel: generic_serial: Unknown symbol restore_flags
Jul 14 20:40:23 toshiba kernel: generic_serial: Unknown symbol save_flags
Jul 14 20:40:23 toshiba kernel: generic_serial: Unknown symbol sti
Jul 14 20:40:41 toshiba kernel: generic_serial: Unknown symbol cli
Jul 14 20:40:41 toshiba kernel: generic_serial: Unknown symbol restore_flags
Jul 14 20:40:41 toshiba kernel: generic_serial: Unknown symbol save_flags
Jul 14 20:40:41 toshiba kernel: generic_serial: Unknown symbol sti
Jul 14 20:42:11 toshiba modprobe: FATAL: Module char_major_10_134 not found.

The kernel 2.5.75-mm1 working good, put modules into the kernel

Helpme please

 Regards.
