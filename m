Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWCIGl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWCIGl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWCIGl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:41:29 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:8670 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751358AbWCIGl2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:41:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PZSR3W9V8bcF+FOFMLxoSdSIsT4tZ68GKuDnLTm76j5RyXUBsDPGafRwY4moFGCXth6djvqB83MElU9exZrwZV1OIZ1aFz97ukMiYgVhqlpecU/gNouTV55WobtViQ9PXEXMdyrtsk3jswmR0KTNMeUXijlxheEBdWnZL62MYzY=
Message-ID: <a44ae5cd0603082241h1eb98c7anb973b26189e35204@mail.gmail.com>
Date: Wed, 8 Mar 2006 22:41:25 -0800
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: v
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[miles@hogwarts ~]$ cat out
Linux version 2.6.16-rc5-mm3 (root@hogwarts.therasim.com) (gcc version
4.1.0 20060304 (Red Hat 4.1.0-2)) #3 Wed Mar 8 20:42:38 PST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003dee0000 (usable)
 BIOS-e820: 000000003dee0000 - 000000003deec000 (ACPI data)
 BIOS-e820: 000000003deec000 - 000000003df00000 (ACPI NVS)
 BIOS-e820: 000000003df00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
94MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7e30
On node 0 totalpages: 253664
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 24288 pages, LIFO batch:3
DMI present.
ACPI: RSDP (v000 HP                                    ) @ 0x000f7e00
ACPI: RSDT (v001 HP     09B8     0x06040000  LTP 0x00000000) @ 0x3dee76bb
ACPI: FADT (v001 HP     09B8     0x06040000 PTL  0x00000050) @ 0x3deebe8c
ACPI: HPET (v001 HP     09B8     0x06040000 PTL  0x00000000) @ 0x3deebf00
ACPI: MADT (v001 HP     09B8     0x06040000 PTL  0x00000050) @ 0x3deebf38
ACPI: MADT (v001 HP     09B8     0x06040000 PTL  0x00000000) @ 0x3deebf92
ACPI: BOOT (v001 HP     09B8     0x06040000  LTP 0x00000001) @ 0x3deebfd8
ACPI: SSDT (v001 HP     09B8     0x00000001 INTL 0x20030224) @ 0x3dee7afe
ACPI: SSDT (v001 HP     09B8     0x00002000 INTL 0x20030224) @ 0x3dee76fb
ACPI: DSDT (v001 HP     09B8     0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0x0
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Detected 1695.880 MHz processor.
Built 1 zonelists
Kernel command line: ro root=LABEL=/1 selinux=0 vga=791 resume=/dev/hda8 rhgb
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c1349000 soft=c1348000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1000496k/1014656k available (1941k kernel code, 13476k
reserved, 1227k data, 164k init, 97152k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3393.56 BogoMIPS (lpj=6787120)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000
00000180 00000000 00000000
CPU: After vendor identify, caps: afe9fbbf 00000000 00000000 00000000
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbbf 00000000 00000000 00000040
00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.70GHz stepping 06
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 910k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060210
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02)
(try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
ACPI: PCI Interrupt Link [LNKC] (IRQs *4)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3)
ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *4)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3)
ACPI: Embedded Controller [H_EC] (gpe 29) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 7 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Setting up standard PCI resources
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bus 3, cardbus bridge: 0000:02:09.0
  IO window: 00003400-000034ff
  IO window: 00003800-000038ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 54000000-55ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: e0200000-e02fffff
  PREFETCH window: 50000000-51ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI (acpi_bus-0216): Device 'CBUS' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 20 (level, low) -> IRQ 16
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1141853660.288:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xe8000000, mapped to 0xf8880000, using 3072k,
total 32576k
vesafb: mode is 1024x768x16, linelength=2048, pages=20
vesafb: protected mode interface info at 00ff:44f0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [THRM] (63 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855 Chipset.
agpgart: Detected 32636K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
[drm] Initialized drm 1.0.1 20051102
ACPI (acpi_bus-0216): Device 'GFX0' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 17
[drm] Initialized i915 1.4.0 20060119 on minor 0
[drm] Initialized i915 1.4.0 20060119 on minor 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI (acpi_bus-0216): Device 'MODM' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 18
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 19
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHU2100AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GMA-4080N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 195371568 sectors (100030 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 20 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:02:09.0 [103c:3080]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:09.0, mfunc 0x01a01b22, devctl 0x64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PSM1] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
I2O subsystem v1.325
i2o: max drivers = 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O ProcFS OSM v1.316
i2c /dev entries driver
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
initcall at 0xc1323844: acpi_cpufreq_init+0x0/0x71(): returned with
error code -16
initcall at 0xc13238b5: cpufreq_p4_init+0x0/0x49(): returned with
error code -16Using IPI Shortcut mode
swsusp: Resume From Partition /dev/hda8
PM: Checking swsusp image.
PM: Resume from disk failed.
ACPI: wakeup devices: PCIB  LAN PS2K PSM1 USB0 USB1 USB2 USB7
ACPI: (supports S0 S3<6>Time: tsc clocksource has been installed.
 S4 S5)
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 164k freed
Write protecting the kernel read-only data: 834k
Time: acpi_pm clocksource has been installed.
Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps: 0xa04713/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
hw_random: RNG not detected
ACPI (acpi_bus-0216): Device 'AUD0' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.5 to 64
8139too Fast Ethernet driver 0.9.27
intel8x0_measure_ac97_clock: measured 53874 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ieee80211_crypt: registered algorithm 'NULL'
MC'97 0 converters and GPIO not ready (0x1)
ACPI (acpi_bus-0216): Device 'LAN' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 17
eth0: RealTek RTL8139 at 0xf8bea800, 00:c0:9f:95:18:1b, IRQ 17
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 17, io base 0x00001820
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.16-rc5-mm3 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.1
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 20, io base 0x00001840
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.16-rc5-mm3 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 19, io base 0x00001860
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.16-rc5-mm3 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI (acpi_bus-0216): Device 'MINI' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 19
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ACPI (acpi_bus-0216): Device 'USB7' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xe0100000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: EHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.16-rc5-mm3 ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
ACPI (acpi_bus-0216): Device 'IEEE' is not power manageable [20060210]
ACPI: PCI Interrupt 0000:02:09.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci1394: fw-host0: Remapped memory spaces reg 0xf8d10000
ohci1394: fw-host0: Soft reset finished
ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=1 initialized
ohci1394: fw-host0: physUpperBoundOffset=00000000
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[22] 
MMIO=[e0207000-e02077ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: CSR: setting expire to 25, HZ=250
Non-volatile memory driver v1.2
ohci1394: fw-host0: IntEvent: 00020010
ohci1394: fw-host0: irq_handler: Bus reset requested
ohci1394: fw-host0: Cancel request received
ohci1394: fw-host0: Got RQPkt interrupt status=0x00008409
ohci1394: fw-host0: Single packet rcv'd
ohci1394: fw-host0: Got phy packet ctx=0 ... discarded
ohci1394: fw-host0: IntEvent: 00010000
ohci1394: fw-host0: SelfID interrupt received (phyid 0, root)
ohci1394: fw-host0: SelfID packet 0x807f8852 received
ieee1394: Including SelfID 0x52887f80
ohci1394: fw-host0: SelfID for this node is 0x807f8852
ohci1394: fw-host0: SelfID complete
ohci1394: fw-host0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ...
irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ieee1394: send packet at S100: 003c0000 ffc3ffff
ohci1394: fw-host0: Inserting packet for node 0-00:0000, tlabel=0,
tcode=0x0, speed=0
ohci1394: fw-host0: Starting transmit DMA ctx=0
ohci1394: fw-host0: IntEvent: 00000001
ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host0: Packet sent to node 60 tcode=0xE tLabel=0 ack=0x11
spd=0 data=0x00000000 ctx=0
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 75150404
ieee1394: received packet: ffc00160 ffc00000 00000000 75150404
ieee1394: send packet local: ffc00540 ffc0ffff f0000404
ieee1394: received packet: ffc00540 ffc0ffff f0000404
ieee1394: send packet local: ffc00560 ffc00000 00000000 34393331
ieee1394: received packet: ffc00560 ffc00000 00000000 34393331
ieee1394: send packet local: ffc00940 ffc0ffff f0000408
ieee1394: received packet: ffc00940 ffc0ffff f0000408
ieee1394: send packet local: ffc00960 ffc00000 00000000 32a264e0
ieee1394: received packet: ffc00960 ffc00000 00000000 32a264e0
ieee1394: send packet local: ffc00d40 ffc0ffff f000040c
ieee1394: received packet: ffc00d40 ffc0ffff f000040c
ieee1394: send packet local: ffc00d60 ffc00000 00000000 009fc000
ieee1394: received packet: ffc00d60 ffc00000 00000000 009fc000
ieee1394: send packet local: ffc01140 ffc0ffff f0000410
ieee1394: received packet: ffc01140 ffc0ffff f0000410
ieee1394: send packet local: ffc01160 ffc00000 00000000 18ec4f00
ieee1394: received packet: ffc01160 ffc00000 00000000 18ec4f00
ieee1394: send packet local: ffc01550 ffc0ffff f0000400 04000000
ieee1394: received packet: ffc01550 ffc0ffff f0000400 04000000
ieee1394: send packet local: ffc01570 ffc00000 00000000 04000000
ieee1394: received packet: ffc01570 ffc00000 00000000 04000000
ieee1394: NodeMgr: raw=0xe064a232 irmc=1 cmc=1 isc=1 bmc=0 pmc=0
cyc_clk_acc=100 max_rec=2048 max_rom=1024 gen=3 lspd=2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00004fec18]
floppy0: no floppy controllers found
lp: driver loaded but no devices found
ibm_acpi: ec object not found
ACPI: Video Device [GFX0] (multi-head: yes  rom: yes  post: no)
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
EXT3 FS on hda6, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Adding 1052216k swap on /dev/hda8.  Priority:-1 extents:1 across:1052216k
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
eth1: NETDEV_TX_BUSY returned; driver should report queue full via
ieee_device->is_queue_full.
ieee80211_crypt: registered algorithm 'WEP'
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present
ADDRCONF(NETDEV_UP): eth1: link is not ready
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
eth1: no IPv6 routers present
PM: suspend-to-disk mode set to 'platform'
Stopping tasks:
============================================================================================================================|
Shrinking memory... done (36889 pages freed)
Suspending device 00c09f00004fec18-0
Suspending device 00c09f00004fec18
Suspending device fw-host0
Suspending device 4-0:1.0
Suspending device usb4
Suspending device 3-0:1.0
Suspending device usb3
Suspending device 2-0:1.0
Suspending device usb2
Suspending device 1-0:1.0
Suspending device usb1
Suspending device 1-0:unknown codec
Suspending device 0-0:unknown codec
Suspending device i2c-0
Suspending device serio1
Suspending device serio0
Suspending device i8042
Suspending device 1.0
Suspending device ide1
Suspending device 0.0
Suspending device ide0
Suspending device serial8250
Suspending device vesafb.0
Suspending device pcspkr
Suspending device 00:06
Suspending device 00:05
Suspending device 00:04
Suspending device 00:03
Suspending device 00:02
Suspending device 00:01
Suspending device 00:00
Suspending device pnp0
Suspending device 0000:02:09.4
Suspending device 0000:02:09.3
Suspending device 0000:02:09.2
Suspending device 0000:02:09.0
Suspending device 0000:02:06.0
eth1: Going into suspend...
ACPI (acpi_bus-0216): Device 'MINI' is not power manageable [20060210]
Suspending device 0000:02:00.0
Suspending device 0000:00:1f.6
Suspending device 0000:00:1f.5
Suspending device 0000:00:1f.3
Suspending device 0000:00:1f.1
Suspending device 0000:00:1f.0
Suspending device 0000:00:1e.0
Suspending device 0000:00:1d.7
ACPI (acpi_bus-0216): Device 'USB7' is not power manageable [20060210]
Suspending device 0000:00:1d.2
Suspending device 0000:00:1d.1
Suspending device 0000:00:1d.0
Suspending device 0000:00:02.1
Suspending device 0000:00:02.0
Suspending device 0000:00:00.3
Suspending device 0000:00:00.1
Suspending device 0000:00:00.0
Suspending device pci0000:00
Suspending device platform
PM: snapshotting memory.
swsusp: Saving Highmem...
swsusp: critical section:
swsusp: Need to copy 93043 pages
swsusp: pages needed: 93043 + 273 + 1024, free: 136436
swsusp: available memory: 136331 pages
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
swsusp: Restoring Highmem
BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
 <c1003f81> show_trace+0xd/0xf   <c100401b> dump_stack+0x17/0x19
 <c1015f77> __might_sleep+0x86/0x90   <c1024738>
blocking_notifier_call_chain+0x1b/0x4d
 <c1183bb2> cpufreq_resume+0xf5/0x11d   <c112b27c> __sysdev_resume+0x23/0x57
 <c112b3c9> sysdev_resume+0x19/0x4b   <c112f736> device_power_up+0x8/0xf
 <c1033339> swsusp_suspend+0x6e/0x8b   <c1033918> pm_suspend_disk+0x51/0xf3
 <c10328c7> enter_state+0x53/0x1c1   <c1032abe> state_store+0x89/0x97
 <c108af00> subsys_attr_store+0x20/0x25   <c108b020> sysfs_write_file+0xb5/0xdc
 <c1056578> vfs_write+0xab/0x154   <c1056aa3> sys_write+0x3b/0x60
 <c1002b43> syscall_call+0x7/0xb
PM: Image restored success
