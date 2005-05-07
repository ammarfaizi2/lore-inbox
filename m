Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVEFXsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVEFXsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVEFXsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:48:09 -0400
Received: from rly-ip05.mx.aol.com ([64.12.138.9]:39617 "EHLO
	rly-ip05.mx.aol.com") by vger.kernel.org with ESMTP id S261376AbVEFXlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:41:09 -0400
Message-ID: <427C0539.40907@yahoo.co.uk>
Date: Sat, 07 May 2005 01:00:57 +0100
From: christos gentsis <christos_gentsis@yahoo.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: why can i see a floppy?
References: <427BF378.5050400@yahoo.co.uk> <427BF168.6010705@tiscali.de>
In-Reply-To: <427BF168.6010705@tiscali.de>
Content-Type: multipart/mixed;
 boundary="------------070704050500030903080501"
X-AOL-IP: 195.93.24.101
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070704050500030903080501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

i have attached the output of the dmesg...

thanks
christos


--------------070704050500030903080501
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

Bootdata ok (command line is auto BOOT_IMAGE=SUSE_LINUX_9.2 root=302 selinux=0 splash=silent console=tty0 resume=/dev/hda1 showopts desktop elevator=as)
Linux version 2.6.11.8 (root@linux) (gcc version 3.3.4 (pre 3.3.5 20040809)) #2 SMP Fri May 6 23:27:06 BST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f6720
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x000000001fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x000000001fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x000000001fff7c00
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000001fff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000001fff0000
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ d0000000 size 128 MB
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=SUSE_LINUX_9.2 root=302 selinux=0 splash=silent console=tty0 resume=/dev/hda1 showopts desktop elevator=as
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1994.890 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 508392k/524224k available (2414k kernel code, 0k reserved, 904k data, 216k init)
Calibrating delay loop... 3948.54 BogoMIPS (lpj=1974272)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(1) -> Node 0
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:.............................................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 714 Objects with 84 Devices 285 Methods 22 Regions
ACPI Namespace successfully loaded at root ffffffff804a0340
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(1) -> Node 0
CPU0: AMD Athlon(tm) 64 Processor 3000+ stepping 08
per-CPU timeslice cutoff: 512.19 usecs.
task migration cache decay timeout: 1 msecs.
Only one processor found.
Using local APIC timer interrupts.
Detected 12.468 MHz APIC timer.
time.c: Using PIT/TSC based timekeeping.
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 01
  groups: 01
  domain 1: span 01
   groups: 01
   domain 2: span 01
    groups: 01
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:.....................................................................
Initialized 22/22 Regions 1/1 Fields 31/31 Buffers 15/23 Packages (723 nodes)
Executing all Device _STA and_INI methods:.......................................................................................
87 Devices found containing: 87 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: 00:00: ioport range 0x1000-0x107f could not be reserved
pnp: 00:00: ioport range 0x1080-0x10ff has been reserved
pnp: 00:00: ioport range 0x1400-0x147f has been reserved
pnp: 00:00: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:00: ioport range 0x1800-0x187f has been reserved
pnp: 00:00: ioport range 0x1880-0x18ff has been reserved
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: match found with the PnP device '00:02' and the driver 'system'
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1115421608.199:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20000100000, using 3072k, total 131072k
vesafb: mode is 1024x768x16, linelength=2048, pages=84
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:08' and the driver 'serial'
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: match found with the PnP device '00:09' and the driver 'serial'
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: MAXTOR 6L040J2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ASUS DRW-1604P, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: Host Protected Area detected.
	current capacity is 78171583 sectors (40023 MB)
	native  capacity is 78177792 sectors (40027 MB)
hda: Host Protected Area disabled.
hda: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS2++ Logitech MX Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
Losing some ticks... checking if CPU frequency changed.
TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
ACPI wakeup devices: 
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
ACPI: (supports S0 S1 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 216k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 18 (level, low) -> IRQ 177
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:01:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x9800. Vers LK1.1.19
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 185
ohci_hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 185, pci mem 0xec003000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.11.8 ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: state 5 ports 3 chg 000e evt 000f
hub 1-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 3, status 0100, change 0000, 12 Mb/s
ohci_hcd 0000:00:02.0: created debug files
ohci_hcd 0000:00:02.0: suspend root hub
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 193
ohci_hcd 0000:00:02.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 193, pci mem 0xec004000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: hcca frame #0003
ohci_hcd 0000:00:02.1: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00010101 CSC PPS CCS
ohci_hcd 0000:00:02.1: supports USB remote wakeup
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.11.8 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: state 5 ports 3 chg 000e evt 000f
hub 2-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 2-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
hub 2-0:1.0: port 3, status 0101, change 0001, 12 Mb/s
ohci_hcd 0000:00:02.1: created debug files
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 201
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: reset hcs_params 0x102486 dbg=1 cc=2 pcc=4 !ppc ports=6
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0 
ehci_hcd 0000:00:02.2: reset hcc_params a086 caching frame 256/512/1024 park
ehci_hcd 0000:00:02.2: capability 0001 at a0
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 201, pci mem 0xec005000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: reset command 080b02 park=3 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: park 0
ehci_hcd 0000:00:02.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
ehci_hcd 0000:00:02.2: supports USB remote wakeup
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.11.8 ehci_hcd
usb usb3: SerialNumber: 0000:00:02.2
usb usb3: hotplug
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010100 CSC PPS
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: ganged power switching
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: Single TT
hub 3-0:1.0: TT requires at most 8 FS bit times
hub 3-0:1.0: power on to power good time: 20ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: enabling power on all ports
hub 2-0:1.0: debounce: port 3: total 175ms stable 100ms status 0x100
hub 3-0:1.0: state 5 ports 6 chg 007e evt 007f
hub 3-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 3-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 3-0:1.0: port 3, status 0100, change 0000, 12 Mb/s
hub 3-0:1.0: port 4, status 0100, change 0000, 12 Mb/s
hub 3-0:1.0: port 5, status 0100, change 0000, 12 Mb/s
ehci_hcd 0000:00:02.2: GetStatus port 6 status 001803 POWER sig=j  CSC CONNECT
hub 3-0:1.0: port 6, status 0501, change 0001, 480 Mb/s
hub 3-0:1.0: debounce: port 6: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 6 full speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 6 status 003001 POWER OWNER sig=se0  CONNECT
hub 2-0:1.0: state 5 ports 3 chg 0000 evt 0008
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS CCS
hub 2-0:1.0: port 3, status 0101, change 0001, 12 Mb/s
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: new full speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [2] = 0x00100103 PRSC PPS PES CCS
usb 2-3: ep0 maxpacket = 8
usb 2-3: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-3: default language 0x0409
usb 2-3: Product: DeskJet 930C
usb 2-3: Manufacturer: Hewlett-Packard
usb 2-3: SerialNumber: ES0BH170GFJJ
usb 2-3: hotplug
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: hotplug
hub 2-0:1.0: state 5 ports 3 chg 0000 evt 0008
gameport: pci0000:01:08.1 speed 1178 kHz
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI interrupt 0000:01:08.2[B] -> GSI 17 (level, low) -> IRQ 209
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209]  MMIO=[eb005000-eb0057ff]  Max Packet=[2048]
Adding 1012052k swap on /dev/hda1.  Priority:42 extents:1
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c002103afdd]
SCSI subsystem initialized
st: Version 20041025, fixed bufsize 32768, s/g segs 256
usblp 2-3:1.0: usb_probe_interface
usblp 2-3:1.0: usb_probe_interface - got id
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x1204
drivers/usb/core/file.c: looking for a minor, starting at 0
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff803face0(lo)
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 312 bytes per conntrack
ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 18 (level, low) -> IRQ 177
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0xa (1300 mV)
cpu_init done, current fid 0xc, vid 0x2
Disabled Privacy Extensions on device ffff81001d0c0000(sit0)
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, low) -> IRQ 217
eth0: no IPv6 routers present
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
atkbd.c: Unknown key pressed (translated set 2, code 0xbb on isa0060/serio0).
atkbd.c: Use 'setkeycodes e03b <keycode>' to make it known.
atkbd.c: Unknown key released (translated set 2, code 0xbb on isa0060/serio0).
atkbd.c: Use 'setkeycodes e03b <keycode>' to make it known.

--------------070704050500030903080501--
