Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTKFCFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 21:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTKFCFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 21:05:51 -0500
Received: from smtp.uol.com.br ([200.221.11.52]:24906 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261719AbTKFCFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 21:05:30 -0500
Date: Wed, 5 Nov 2003 15:56:09 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-usb-users@lists.sourceforge.net
Subject: Problems with USB Drive
Message-ID: <20031105175609.GA967@ime.usp.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Dear developers,

Last July, I bought myself an USB Drive (a Leading Driver UD-11, with
128MB) with the intention of carrying my personal files on it.

Despite being able to fully use it under MacOS X and Windows, I have
been having problems with it with Linux.

It is funny that my USB printer (an HP Deskjet 840C) works wonderfully
under Linux, which leads me to think that something may be wrong with
usb-storage.

My longest experience is with the Linux 2.4 series and I've had problems
with at least kernels 2.4.x, with x >= 20 (the ones I tried). The
problem is still present in the recent 2.4.23-pre9 that Marcelo
released.

The funny part of the problem is that I sometimes *can* mount my drive,
but only part of the time (like 20% of the times that I try). The other
times, the kernel just spews a lot of error messages to my console.

Trying to see if the problem would go away with a 2.6 kernel, I
downloaded 2.6.0-test9 and tried it anyway. The problems still persist.

Thus, I am including some files from the 2.6 kernel that I am running
now and I would appreciate any help that you could provide me with
getting this drive working under Linux, as it is my main OS.

The files that I found relevant are attached.

If anything is missing or if other information is needed, please don't
hesitate to ask.


Thanks in advance for any help, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--cWoXeonUoKmBZSoM
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.0-test9-1 (root@dumont) (gcc version 3.3.2 (Debian)) #1 Wed Nov 5 14:50:36 BRST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007fec000 (usable)
 BIOS-e820: 0000000007fec000 - 0000000007fef000 (ACPI data)
 BIOS-e820: 0000000007fef000 - 0000000007fff000 (reserved)
 BIOS-e820: 0000000007fff000 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32748
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28652 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux root=303 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 605.655 MHz processor.
Console: colour VGA+ 80x25
Memory: 127124k/130992k available (1312k kernel code, 3324k reserved, 428k data, 104k init, 0k highmem)
Calibrating delay loop... 1191.93 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1010, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 81 & 1f -> 01
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: AGP aperture is 64M @ 0xe4000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLlct15 30, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
PCI: Found IRQ 10 for device 0000:00:11.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x8000-0x8007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8008-0x800f, BIOS settings: hdg:pio, hdh:pio
hda: max request size: 128KiB
hda: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)
 hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 104k freed
Adding 248996k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 9 for device 0000:00:0d.0
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:09.0
eth0: RealTek RTL8139 at 0xc883f000, 00:e0:7d:96:28:8f, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
SCSI subsystem initialized
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: ASUS      Model: DVD-ROM E608      Rev: l.40
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HP        Model: CD-Writer+ 9100   Rev: 1.0a
  Type:   CD-ROM                             ANSI SCSI revision: 02
es1371: version v0.32 time 15:04:30 Nov  5 2003
PCI: Found IRQ 9 for device 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:0d.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xa400 irq 9 joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
lp0: using parport0 (polling).
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
quotaon: numerical sysctl 5 16 8 is obsolete.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 9 for device 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: irq 9, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:04.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0-test9-1 uhci_hcd
usb usb1: SerialNumber: 0000:00:04.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
PCI: Found IRQ 9 for device 0000:00:04.3
PCI: Sharing IRQ 9 with 0000:00:04.2
PCI: Sharing IRQ 9 with 0000:00:09.0
PCI: Sharing IRQ 9 with 0000:00:0d.0
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: irq 9, io base 0000d000
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:04.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.0-test9-1 uhci_hcd
usb usb2: SerialNumber: 0000:00:04.3
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
hub 1-0:1.0: port 1, status 300, change 3, 1.5 Mb/s
hub 1-0:1.0: port 2, status 300, change 3, 1.5 Mb/s
hub 2-0:1.0: port 1, status 101, change 3, 12 Mb/s
hub 2-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:1.0: new USB device on port 1, assigned address 2
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=3
drivers/usb/core/message.c: USB device number 2 default language ID 0x409
usb 2-1: Product: DeskJet 840C
usb 2-1: Manufacturer: Hewlett-Packard 
usb 2-1: SerialNumber: BR1391S0WNKV
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: registering 2-1:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: port 2, status 101, change 3, 12 Mb/s
hub 2-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 2-0:1.0: new USB device on port 2, assigned address 3
usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 3 default language ID 0x409
usb 2-2: Product: Generic USB Hub
usb 2-2: Manufacturer: ALCOR
drivers/usb/core/usb.c: usb_hotplug
usb 2-2: registering 2-2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-2:1.0: usb_probe_interface
hub 2-2:1.0: usb_probe_interface - got id
hub 2-2:1.0: USB hub found
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
hub 2-2:1.0: 4 ports detected
hub 2-2:1.0: standalone hub
hub 2-2:1.0: ganged power switching
hub 2-2:1.0: global over-current protection
hub 2-2:1.0: Port indicators are not supported
hub 2-2:1.0: power on to power good time: 44ms
hub 2-2:1.0: hub controller current requirement: 100mA
hub 2-2:1.0: local power source is good
hub 2-2:1.0: no over-current condition exists
hub 2-2:1.0: enabling power on all ports
hub 1-0:1.0: port 1 enable change, status 300
hub 1-0:1.0: port 2 enable change, status 300
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
drivers/usb/host/uhci-hcd.c: d400: suspend_hc
usblp 2-1:1.0: usb_probe_interface
usblp 2-1:1.0: usb_probe_interface - got id
drivers/usb/class/usblp.c: Disabling reads from problem bidirectional printer on usblp0
drivers/usb/class/usblp.c: usblp0: USB Unidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604
drivers/usb/core/file.c: looking for a minor, starting at 0
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb 2-1: hcd_unlink_urb c74e3f80 fail -22
usb 2-1: hcd_unlink_urb c74e3f80 fail -22
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
hub 2-2:1.0: port 2, status 101, change 1, 12 Mb/s
hub 2-2:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 2-2:1.0: new USB device on port 2, assigned address 4
usb 2-2.2: new device strings: Mfr=1, Product=3, SerialNumber=0
drivers/usb/core/message.c: USB device number 4 default language ID 0x409
usb 2-2.2: Product: USB Embedded Hub
usb 2-2.2: Manufacturer: Leading Driver Co.,LTD.
drivers/usb/core/usb.c: usb_hotplug
usb 2-2.2: registering 2-2.2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-2.2:1.0: usb_probe_interface
hub 2-2.2:1.0: usb_probe_interface - got id
hub 2-2.2:1.0: USB hub found
hub 2-2.2:1.0: 2 ports detected
hub 2-2.2:1.0: compound device; port removable status: FF
hub 2-2.2:1.0: individual port power switching
hub 2-2.2:1.0: individual port over-current protection
hub 2-2.2:1.0: Port indicators are not supported
hub 2-2.2:1.0: power on to power good time: 100ms
hub 2-2.2:1.0: hub controller current requirement: 100mA
hub 2-2.2:1.0: local power source is lost (inactive)
hub 2-2.2:1.0: no over-current condition exists
hub 2-2.2:1.0: enabling power on all ports
hub 2-2.2:1.0: port 1, status 101, change 1, 12 Mb/s
hub 2-2.2:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-2.2:1.0: new USB device on port 1, assigned address 5
hub 2-2.2:1.0: transfer --> -75
usb 2-2.2.1: control timeout on ep0in

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="lspci-v.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Flags: bus master, medium devsel, latency 0
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e0800000-e1dfffff
	Prefetchable memory behind bridge: e1f00000-e3ffffff
	Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Flags: bus master, stepping, medium devsel, latency 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2

00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative SoundBlaster AudioPCI 128
	Flags: bus master, slow devsel, latency 32, IRQ 9
	I/O ports at a400 [size=64]
	Capabilities: [dc] Power Management version 1

00:0a.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: 5610 56K FaxModem USR 56k Internal Voice Modem (Model 2976)
	Flags: medium devsel, IRQ 5
	I/O ports at a000 [size=8]
	Capabilities: [dc] Power Management version 2

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at 9800 [size=256]
	Memory at e0000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 9400 [size=8]
	I/O ports at 9000 [size=4]
	I/O ports at 8800 [size=8]
	I/O ports at 8400 [size=4]
	I/O ports at 8000 [size=64]
	Memory at df800000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at e2000000 (32-bit, prefetchable) [size=32M]
	Memory at e1000000 (32-bit, non-prefetchable) [size=16K]
	Memory at e0800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e1ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0a.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model 5610 (rev 01)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="mount.txt"

mount: /dev/sda1 is not a valid block device

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="uname-a.txt"

Linux dumont 2.6.0-test9-1 #1 Wed Nov 5 14:50:36 BRST 2003 i686 GNU/Linux

--cWoXeonUoKmBZSoM--
