Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVE0NFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVE0NFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVE0NEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:04:55 -0400
Received: from [209.203.41.250] ([209.203.41.250]:43268 "EHLO
	bventer01.shoden.co.za") by vger.kernel.org with ESMTP
	id S262462AbVE0M6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:58:35 -0400
Message-ID: <42971978.3090500@shoden.co.za>
Date: Fri, 27 May 2005 14:58:32 +0200
From: Bennie Kahler-Venter <bennie.venter@shoden.co.za>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: mouse still losing sync and thus jumping around
References: <42271D67.4020300@shoden.co.za> <20050525150713.3b3c2a09.akpm@osdl.org>
In-Reply-To: <20050525150713.3b3c2a09.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050204010408010104070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050204010408010104070907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>
> Could you please retest 2.6.12-rc5?

Did test the kernel with both ACPI and APM enabled:

As you can see from dmesg.out there is till a sync loss.

config.gz contains the configuration I built the kernel with
(a copy from /proc/config.gz)

Tnx & Bi
Bennie Kahler-Venter



--------------050204010408010104070907
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
DMtS2t4U1O//AxAcjAPq0QAA
--------------050204010408010104070907
Content-Type: text/plain;
 name="dmesg.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.out"

Linux version 2.6.11.7 (root@Rescue) (gcc version 3.3.4 (pre 3.3.5 20040809)) #5 Mon Apr 25 14:30:12 SAST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffe0000 (usable)
 BIOS-e820: 000000000ffe0000 - 000000000fff8000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65504
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61408 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 Acer                                  ) @ 0x000fe030
ACPI: RSDT (v001 Acer   TMH2     0x00000001 Acer 0x00000000) @ 0x0ffe0000
ACPI: FADT (v001 Acer   TMH2     0x00000001 Acer 0x00000000) @ 0x0ffe0054
ACPI: BOOT (v001 Acer   TMH2     0x00000001 Acer 0x00000000) @ 0x0ffe002c
ACPI: DSDT (v001    H2       H2  0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0xf108
Allocating PCI resources starting at 10000000 (gap: 0fff8000:efff8000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 vga=0x317 selinux=0 resume=/dev/hda2 desktop elevator=as splash=silent
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01201000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1800.559 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 253832k/262016k available (2488k kernel code, 7568k reserved, 988k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3563.52 BogoMIPS (lpj=1781760)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 3febf9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: 3febf9ff 00000000 00000000 00000080 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................................................................................................................................
Table [DSDT](id F004) - 519 Objects with 50 Devices 159 Methods 34 Regions
ACPI Namespace successfully loaded at root c04d6840
ACPI: setting ELCR to 0200 (from 0c00)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1042k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 3 Wake, Enabled 3 Runtime GPEs in this block
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:....................................................................................
Initialized 34/34 Regions 10/10 Fields 30/30 Buffers 10/17 Packages (528 nodes)
Executing all Device _STA and_INI methods:.......................................................
55 Devices found containing: 55 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [PILA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [PILC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PILH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
pnp: 00:0a: ioport range 0xf100-0xf17f could not be reserved
pnp: 00:0a: ioport range 0xf200-0xf23f has been reserved
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x580-0x587 has been reserved
Simple Boot Flag at 0x6e set to 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x0f (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1117204892.838:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
vesafb: framebuffer at 0x88000000, mapped to 0xd0880000, using 3072k, total 32768k
vesafb: mode is 1024x768x16, linelength=2048, pages=20
vesafb: protected mode interface info at c000:5229
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [PILB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 5
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbc90-0xbc97, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbc98-0xbc9f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHR2020AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SR243T, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 39070080 sectors (20003 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio2
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
input: PC Speaker
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
PM: Reading swsusp image.
swsusp: Resume From Partition: /dev/hda2
<3>swsusp: Suspend partition has wrong signature?
swsusp: Error -22 resuming
PM: Resume from disk failed.
ACPI wakeup devices: 
SLPB OZ68 OZ69 OBLN OBMO ICH2  LID 
ACPI: (supports S0 S3 S4 S4bios S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 220k freed
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xd083e800, 00:00:e2:7f:66:34, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ndiswrapper version 1.1 loaded (preempt=yes,smp=no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [PILD] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1f.2[D] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 11, io base 0x8000
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [PILH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: irq 11, io base 0x8060
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hw_random: RNG not detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 256M @ 0xe0000000
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [PILF] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[80100000-801007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[ffff9be000000000]
SCSI subsystem initialized
st: Version 20041025, fixed bufsize 32768, s/g segs 256
ACPI: PCI Interrupt Link [PILC] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:09.0 [1025:1027]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:09.0, mfunc 0x01001022, devctl 0x64
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt Link [PILG] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:09.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:09.1 [1025:1027]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:09.1, mfunc 0x01001022, devctl 0x64
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000006
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
subfs 0.9
Adding 265064k swap on /dev/hda2.  Priority:42 extents:1
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x100-0x3af: excluding 0x378-0x38f
cs: IO port probe 0x100-0x3af: excluding 0x378-0x38f
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c041ff80(lo)
IPv6 over IPv4 tunneling driver
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49384 usecs
intel8x0: clocking to 48000
Disabled Privacy Extensions on device ce166000(sit0)
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
acpi_processor-0561 [08] acpi_processor_get_pow: count given by _CST is not valid
ACPI: Thermal Zone [THR1] (47 C)
ACPI: Thermal Zone [THR2] (45 C)
powernow: This module only works with AMD K7 CPUs
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Non-volatile memory driver v1.2
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt Link [PILA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.14.0 20050125 on minor 0: ATI Technologies Inc Radeon Mobility M6 LY
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
psmouse.c: Mouse at isa0060/serio2/input0 lost synchronization, throwing 2 bytes away.
psmouse.c: Mouse at isa0060/serio2/input0 lost synchronization, throwing 1 bytes away.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 17
psmouse.c: Mouse at isa0060/serio2/input0 lost synchronization, throwing 2 bytes away.
eth0: no IPv6 routers present
psmouse.c: Mouse at isa0060/serio2/input0 lost synchronization, throwing 1 bytes away.

--------------050204010408010104070907--
