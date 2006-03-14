Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWCNO3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWCNO3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWCNO3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:29:48 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:25438 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750765AbWCNO3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:29:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=l9YCp2jztw8CmjF/EzUGYaI+2BsuHsu+D2RI3s0txZBBfgV/f75cHT5SWJehE1b/yZgecf2bVIq594SOtXOb82rr+plLZHdo61lcXVHnvC7wJyWbQqbxWh/XoINPqasnC3EmtiBlnpl0o2xvRWt4C3VjRgnTnDrS1RVyPmP5UAk=
Message-ID: <a07a17720603140629o86b9974xb85eb9728dde5a55@mail.gmail.com>
Date: Tue, 14 Mar 2006 19:59:23 +0530
From: "Allen Pradeep" <allenpradeep@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: reg. sis 900 drivers
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1452_6105670.1142346563184"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1452_6105670.1142346563184
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

sir, i'm a linux novice user.. i run fedora core3 and winXP.. i'm
using a asus mother board which comes with a internal sis900 ethernet
card. whenever i start fedora i get an error message stating
"Sis 900 device eth0 does not seem to be present. Delaying initialization"

i'm also not able to connect to the internet. with winXP i can!!!!
 i wrote a mail to webmaster@brownhat.org with outputs of the
following commands:
>modprobe sis900
>dmesg
>lspci

he gave a reply stating that sis900 adapter is not found in your
system: his reply was this
"I don't think that you have a sis900 adapter in your computer. lspci
lists your network adapter as unknown, so I think you should write to
linux-kernel@vger.kernel.org (the main development list) and ask for
 help there"

 so i have mailed u regarding this... i'm really interested in linux
and because i'm not able to connect to the net, i'm using winXP
 i've run the following commands:
> modprobe sis900 > foo.txt
> dmesg > bar.txt
> lspci > baz.txt
 and have attached foo.txt, bar.txt, baz.txt along with this mail...

 i would be greateful to you if u help me in solving this problem.
please send the drivers needed and also tell me how to install them
since i'm a novice user...
 thanking you in advance
 hoping for a prompt response...

------=_Part_1452_6105670.1142346563184
Content-Type: text/plain; name=foo.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eksbindn
Content-Disposition: attachment; filename="foo.txt"


------=_Part_1452_6105670.1142346563184
Content-Type: text/plain; name=bar.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eksbiuzi
Content-Disposition: attachment; filename="bar.txt"

rd memory: 385k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 3
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1142272106.4294965271:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 6ECDA687281A73E5
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: Processor [CPU1] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 760 chipset
agpgart: Maximum main memory to use for agp memory: 658M
agpgart: AGP aperture is 4M @ 0xe0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 1
SIS5513: not 100% native mode: will probe irqs later
Probing IDE interface ide0...
hda: ST340015A, ATA DISK drive
Probing IDE interface ide1...
hdc: HL-DT-ST GCE-8527B, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 > hda3
hdc: ATAPI 52X CD-ROM CD-R/RW drive, 1536kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 37449)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
PCI0 PS2K PS2M EUSB  USB USB2 USB3  MAC AC97 MC97 P0P2 
Freeing unused kernel memory: 144k freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 4 roles, 280 types, 16 bools
security:  53 classes, 5494 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda3, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured for labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
spurious 8259A interrupt: IRQ7.
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
inserting floppy driver for 2.6.9-1.667
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
sis900: Unknown parameter `irq'
sis900.c: v1.08.07 11/02/2003
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 11 (level, low) -> IRQ 11
intel8x0_measure_ac97_clock: measured 49556 usecs
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 10, pci mem 308b8000
SELinux: initialized (dev usbdevfs, type usbdevfs), uses genfs_contexts
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: irq 10, pci mem 308ba000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 3 (level, low) -> IRQ 3
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: irq 3, pci mem 308f4000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: irq 5, pci mem 308f6000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
Disabled Privacy Extensions on device 02369a00(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
ACPI: Power Button (FF) [PWRF]
Losing some ticks... checking if CPU frequency changed.
EXT3 FS on hda3, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Losing some ticks... checking if CPU frequency changed.
cdrom: open failed.
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
parport0: PC-style at 0x378 [PCSPP]
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (5886 buckets, 47088 max) - 356 bytes per conntrack
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
i2c /dev entries driver
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing some ticks... checking if CPU frequency changed.
Losing too many ticks!
TSC cannot be used as a timesource.  
Possible reasons for this are:
  You're running with Speedstep,
  You don't have DMA enabled for your hard disk (see hdparm),
  Incorrect TSC synchronization on an SMP system (see dmesg).
Falling back to a sane timesource now.
parport0: PC-style at 0x378 [PCSPP]
lp0: using parport0 (polling).
lp0: console ready
SELinux: initialized (dev hda6, type vfat), uses genfs_contexts

------=_Part_1452_6105670.1142346563184
Content-Type: text/plain; name=baz.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_eksbix9z
Content-Disposition: attachment; filename="baz.txt"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 760/M760 Host (rev 03)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS965 [MuTIOL Media IO] (rev 47)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 01)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS]: Unknown device 0190
00:06.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 000a
00:07.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown device 000a
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 661FX/M661FX/M661MX/741/M741/760/M760 PCI/AGP

------=_Part_1452_6105670.1142346563184--
