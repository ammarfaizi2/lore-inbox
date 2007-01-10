Return-Path: <linux-kernel-owner+w=401wt.eu-S932810AbXAJNrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbXAJNrH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932818AbXAJNrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:47:07 -0500
Received: from ms-smtp-02.ohiordc.rr.com ([65.24.5.136]:40203 "EHLO
	ms-smtp-02.ohiordc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810AbXAJNrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:47:01 -0500
Subject: RE: PROBLEM: LSIFC909 mpt card fails to recognize devices
From: Justin Rosander <myrddinemrys@neo.rr.com>
To: "Moore, Eric" <Eric.Moore@lsi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <664A4EBB07F29743873A87CF62C26D704E90EF@NAMAIL4.ad.lsil.com>
References: <664A4EBB07F29743873A87CF62C26D704E90EF@NAMAIL4.ad.lsil.com>
Content-Type: multipart/mixed; boundary="=-Hmvrz213OdcutZ4j6OWd"
Date: Wed, 10 Jan 2007 08:46:50 -0500
Message-Id: <1168436810.5200.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hmvrz213OdcutZ4j6OWd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Eric.
Here you go.  Let me know if there's anything else that you need . . .
Regards,
Justin
On Mon, 2007-01-08 at 18:16 -0700, Moore, Eric wrote:
> Justin wrote:
> 
> > Success! Here you are
> 
> Can you send the dmesg, boot.log, or messages from /var/log ?
> 
> It appears you've sent me lspci output instead.
> 
> Eric.

--=-Hmvrz213OdcutZ4j6OWd
Content-Disposition: attachment; filename=dmesg.log
Content-Type: text/x-log; name=dmesg.log; charset=utf-8
Content-Transfer-Encoding: 7bit

B)
      .data : 0xb02880d5 - 0xb0311f94   ( 551 kB)
      .text : 0xb0100000 - 0xb02880d5   (1568 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4008.13 BogoMIPS (lpj=2004067)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Sempron(tm)   2800+ stepping 00
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0e20)
checking if image is initramfs... it is
Freeing initrd memory: 4742k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb2f0, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: MSI-K8T-Neo2Fir, attempting to turn soundcard ON
PCI: MSI-K8T-Neo2Fir, soundcard on
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12) *5
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:02: ioport range 0x4000-0x407f could not be reserved
pnp: 00:02: ioport range 0x40f0-0x40ff could not be reserved
pnp: 00:02: ioport range 0x5000-0x500f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e0000000-e1ffffff
  PREFETCH window: d8000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 7, 524288 bytes)
TCP bind hash table entries: 8192 (order: 5, 229376 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1168417631.540:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI Shortcut mode
ACPI: (supports S0 S1 S4 S5)
Switched to high resolution mode on CPU 0
Freeing unused kernel memory: 176k freed
via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
eth0: VIA Rhine II at 0x1e000, 00:0f:ea:02:d9:a8, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 10, io mem 0xe3036000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem initialized
Fusion MPT base driver 3.04.02
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT FC Host driver 3.04.02
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:0a.2[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[e3035000-e30357ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 11, io base 0x0000cc00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 11, io base 0x0000d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-4: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 11, io base 0x0000d400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-4: configuration #1 chosen from 1 choice
hub 1-4:1.0: USB hub found
hub 1-4:1.0: 4 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 11, io base 0x0000d800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
mptbase: mpt_adapter_install
mptbase: mem = d0940000, mem_phys = e3000000
mptbase: facts @ cfe1f2a4, pfacts[0] @ cfe1f2f4
mptbase: Initiating ioc0 bringup
mptbase: ioc0: IOC operational unexpected
mptbase: whoinit 0x2 statefault 0 force 0
mptbase: ioc0: Sending get IocFacts request req_sz=12 reply_sz=80
mptbase: ioc0: NB_for_64_byte_frame=2 NBShiftFactor=5 BlockSize=8
mptbase: ioc0: reply_sz= 80, reply_depth= 128
mptbase: ioc0: req_sz  =128, req_depth  =1023
mptbase: ioc0: Sending get PortFacts(0) request
ioc0: FC909: Capabilities={Initiator,LAN}
mptbase: ioc0 ReqToChain alloc  @ ced75000, sz=4092 bytes
mptbase: ioc0 RequestNB alloc  @ cec4d000, sz=4092 bytes
mptbase: ioc0 num_sge=25 numSGE=490
mptbase: ioc0 Now numSGE=40 num_sge=40 num_chain=3
mptbase: ioc0 ChainToChain alloc @ ced34800, sz=1524 bytes
mptbase: ioc0.ReplyBuffer sz=80 bytes, ReplyDepth=128
mptbase: ioc0.ReplyBuffer sz=10240[2800] bytes
mptbase: ioc0.RequestBuffer sz=128 bytes, RequestDepth=1023
mptbase: ioc0.RequestBuffer sz=130944[1ff80] bytes
mptbase: ioc0.ChainBuffer sz=128 bytes, ChainDepth=381
mptbase: ioc0.ChainBuffer sz=48768[be80] bytes num_chain=381
mptbase: ioc0.Total alloc @ cee00000[1ee00000], sz=189952[2e600] bytes
mptbase: ioc0 ReplyBuffers @ cee00000[1ee00000]
mptbase: ioc0 RequestBuffers @ cee02800[1ee02800]
mptbase :ioc0 ChainBuffers @ cee22780(1ee22780)
mptbase: ioc0.SenseBuffers @ cedd0000[1edd0000]
mptbase: ioc0.ReplyBuffers @ cee00000[1ee00000]
mptbase: ioc0: facts.MsgVersion=100
mptbase: ioc0: Sending Port(0)Enable (req @ cf21bc20)
mptbase: ioc0: INFO - Wait IOC_OPERATIONAL state (cnt=0)
scsi0 : ioc0: LSIFC909, FwRev=01000000h, Ports=1, MaxQ=1023, IRQ=11
VP_IDE: IDE controller at PCI slot 0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:0f.0, from 255 to 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.0
    ide0: BM-DMA at 0xc800-0xc807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc808-0xc80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD1200JB-00GVC0, ATA DISK drive
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c00a1037514]
usb 1-4.3: new low speed USB device using ehci_hcd and address 4
usb 1-4.3: configuration #1 chosen from 1 choice
hdb: TSSTcorpCD/DVDW SH-S182M, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
usb 1-4.4: new full speed USB device using ehci_hcd and address 5
usb 1-4.4: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
hdc: WDC WD307AA, ATA DISK drive
usb 5-2: new full speed USB device using uhci_hcd and address 2
usb 5-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Gyration GyroPoint RF Technology Receiver as /class/input/input0
input: USB HID v1.00 Keyboard [Gyration GyroPoint RF Technology Receiver] on usb-0000:00:10.4-4.3
input: Gyration GyroPoint RF Technology Receiver as /class/input/input1
input,hiddev96: USB HID v1.00 Mouse [Gyration GyroPoint RF Technology Receiver] on usb-0000:00:10.4-4.3
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: Host Protected Area detected.
	current capacity is 234439535 sectors (120033 MB)
	native  capacity is 234441648 sectors (120034 MB)
hda: Host Protected Area disabled.
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 >
hdc: max request size: 128KiB
hdb: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: Host Protected Area detected.
	current capacity is 60072671 sectors (30757 MB)
	native  capacity is 60074784 sectors (30758 MB)
hdc: Host Protected Area disabled.
hdc: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=59598/16/63, UDMA(66)
hdc: cache flushes not supported
 hdc: hdc1
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
scsi 1:0:0:0: Direct-Access     HP       psc 2410         1.00 PQ: 0 ANSI: 2
usb-storage: device scan complete
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 5 if 1 alt 0 proto 2 vid 0x03F0 pid 0x3611
usbcore: registered new interface driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
input: PC Speaker as /class/input/input2
mice: PS/2 mouse device common for all mice
Linux agpgart interface v0.101 (c) Dave Jones
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Real Time Clock Driver v1.12ac
Floppy drive(s): fd0 is 1.44M
gameport: NS558 PnP Gameport is pnp00:0c/gameport0, io 0x201, speed 946kHz
FDC 0 is a post-1991 82077
Bluetooth: HCI USB driver ver 2.9
Linux video capture interface: v2.00
usbcore: registered new interface driver hci_usb
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
saa7130/34: v4l2 driver version 0.2.14 loaded
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
saa7133[0]: found at 0000:00:0b.0, rev: 16, irq: 11, latency: 32, mmio: 0xe3034000
saa7133[0]: subsystem: 1043:4843, board: ASUS TV-FM 7133 [card=25,autodetected]
saa7133[0]: board init: gpio is 0
sd 1:0:0:0: Attached scsi removable disk sda
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
saa7133[0]: i2c eeprom 00: 43 10 43 48 ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
saa7133[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
tuner 0-0043: chip found @ 0x86 (saa7133[0])
tda9887 0-0043: tda988[5/6/7] found @ 0x43 (tuner)
tuner 0-0060: All bytes are equal. It is not a TEA5767
tuner 0-0060: chip found @ 0xc0 (saa7133[0])
tuner 0-0060: type set to 43 (Philips NTSC MK3 (FM1236MK3 or FM1236/F))
tuner 0-0060: type set to 43 (Philips NTSC MK3 (FM1236MK3 or FM1236/F))
saa7133[0]: registered device video0 [v4l2]
saa7133[0]: registered device vbi0
saa7133[0]: registered device radio0
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Installing spdif_bug patch: Audigy 2 ZS [SB0353]
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Adding 497952k swap on /dev/hda5.  Priority:-1 extents:1 across:497952k
EXT3 FS on hda2, internal journal
it87: Found IT8705F chip at 0x290, revision 3
it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
lp0: using parport0 (interrupt-driven).
ppdev: user-space parallel port driver
eth0: no IPv6 routers present

--=-Hmvrz213OdcutZ4j6OWd
Content-Disposition: attachment; filename=messages1.log
Content-Type: text/x-log; name=messages1.log; charset=utf-8
Content-Transfer-Encoding: 7bit

Jan 10 00:00:32 localhost -- MARK --
Jan 10 00:20:32 localhost -- MARK --
Jan 10 00:21:25 localhost gconfd (root-6556): starting (version 2.16.0), pid 6556 user 'root'
Jan 10 00:21:25 localhost gconfd (root-6556): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Jan 10 00:21:25 localhost gconfd (root-6556): Resolved address "xml:readwrite:/root/.gconf" to a writable configuration source at position 1
Jan 10 00:21:25 localhost gconfd (root-6556): Resolved address "xml:readonly:/usr/share/cdd/gconf.xml.defaults" to a read-only configuration source at position 2
Jan 10 00:21:25 localhost gconfd (root-6556): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Jan 10 00:21:25 localhost gconfd (root-6556): Resolved address "xml:readonly:/var/lib/gconf/debian.defaults" to a read-only configuration source at position 4
Jan 10 00:21:25 localhost gconfd (root-6556): Resolved address "xml:readonly:/var/lib/gconf/defaults" to a read-only configuration source at position 5
Jan 10 00:31:25 localhost gconfd (root-6556): GConf server is not in use, shutting down.
Jan 10 00:31:25 localhost gconfd (root-6556): Exiting
Jan 10 00:41:18 localhost gconfd (root-7200): starting (version 2.16.0), pid 7200 user 'root'
Jan 10 00:41:18 localhost gconfd (root-7200): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Jan 10 00:41:18 localhost gconfd (root-7200): Resolved address "xml:readwrite:/root/.gconf" to a writable configuration source at position 1
Jan 10 00:41:18 localhost gconfd (root-7200): Resolved address "xml:readonly:/usr/share/cdd/gconf.xml.defaults" to a read-only configuration source at position 2
Jan 10 00:41:18 localhost gconfd (root-7200): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Jan 10 00:41:18 localhost gconfd (root-7200): Resolved address "xml:readonly:/var/lib/gconf/debian.defaults" to a read-only configuration source at position 4
Jan 10 00:41:18 localhost gconfd (root-7200): Resolved address "xml:readonly:/var/lib/gconf/defaults" to a read-only configuration source at position 5
Jan 10 00:42:48 localhost gconfd (root-7200): GConf server is not in use, shutting down.
Jan 10 00:42:48 localhost gconfd (root-7200): Exiting
Jan 10 00:50:35 localhost gconfd (root-7607): starting (version 2.16.0), pid 7607 user 'root'
Jan 10 00:50:35 localhost gconfd (root-7607): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Jan 10 00:50:35 localhost gconfd (root-7607): Resolved address "xml:readwrite:/root/.gconf" to a writable configuration source at position 1
Jan 10 00:50:35 localhost gconfd (root-7607): Resolved address "xml:readonly:/usr/share/cdd/gconf.xml.defaults" to a read-only configuration source at position 2
Jan 10 00:50:35 localhost gconfd (root-7607): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Jan 10 00:50:35 localhost gconfd (root-7607): Resolved address "xml:readonly:/var/lib/gconf/debian.defaults" to a read-only configuration source at position 4
Jan 10 00:50:35 localhost gconfd (root-7607): Resolved address "xml:readonly:/var/lib/gconf/defaults" to a read-only configuration source at position 5
Jan 10 00:51:05 localhost gconfd (root-7607): GConf server is not in use, shutting down.
Jan 10 00:51:05 localhost gconfd (root-7607): Exiting
Jan 10 00:54:21 localhost gconfd (root-7705): starting (version 2.16.0), pid 7705 user 'root'
Jan 10 00:54:21 localhost gconfd (root-7705): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Jan 10 00:54:21 localhost gconfd (root-7705): Resolved address "xml:readwrite:/root/.gconf" to a writable configuration source at position 1
Jan 10 00:54:21 localhost gconfd (root-7705): Resolved address "xml:readonly:/usr/share/cdd/gconf.xml.defaults" to a read-only configuration source at position 2
Jan 10 00:54:21 localhost gconfd (root-7705): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Jan 10 00:54:21 localhost gconfd (root-7705): Resolved address "xml:readonly:/var/lib/gconf/debian.defaults" to a read-only configuration source at position 4
Jan 10 00:54:21 localhost gconfd (root-7705): Resolved address "xml:readonly:/var/lib/gconf/defaults" to a read-only configuration source at position 5
Jan 10 00:56:21 localhost gconfd (root-7705): GConf server is not in use, shutting down.
Jan 10 00:56:21 localhost gconfd (root-7705): Exiting
Jan 10 01:06:37 localhost gconfd (myrddin-5073): Exiting
Jan 10 01:06:37 localhost gconfd (myrddin-8092): starting (version 2.16.0), pid 8092 user 'myrddin'
Jan 10 01:06:38 localhost gconfd (myrddin-8092): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Jan 10 01:06:38 localhost gconfd (myrddin-8092): Resolved address "xml:readwrite:/home/myrddin/.gconf" to a writable configuration source at position 1
Jan 10 01:06:38 localhost gconfd (myrddin-8092): Resolved address "xml:readonly:/usr/share/cdd/gconf.xml.defaults" to a read-only configuration source at position 2
Jan 10 01:06:38 localhost gconfd (myrddin-8092): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Jan 10 01:06:38 localhost gconfd (myrddin-8092): Resolved address "xml:readonly:/var/lib/gconf/debian.defaults" to a read-only configuration source at position 4
Jan 10 01:06:38 localhost gconfd (myrddin-8092): Resolved address "xml:readonly:/var/lib/gconf/defaults" to a read-only configuration source at position 5
Jan 10 01:07:00 localhost kernel: agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
Jan 10 01:07:00 localhost kernel: agpgart: Device is in legacy mode, falling back to 2.x
Jan 10 01:07:00 localhost kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Jan 10 01:07:00 localhost kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Jan 10 01:07:08 localhost gconfd (myrddin-8092): GConf server is not in use, shutting down.
Jan 10 01:07:08 localhost gconfd (myrddin-8092): Exiting
Jan 10 01:07:08 localhost gconfd (myrddin-8283): starting (version 2.16.0), pid 8283 user 'myrddin'
Jan 10 01:07:08 localhost gconfd (myrddin-8283): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Jan 10 01:07:08 localhost gconfd (myrddin-8283): Resolved address "xml:readwrite:/home/myrddin/.gconf" to a writable configuration source at position 1
Jan 10 01:07:08 localhost gconfd (myrddin-8283): Resolved address "xml:readonly:/usr/share/cdd/gconf.xml.defaults" to a read-only configuration source at position 2
Jan 10 01:07:08 localhost gconfd (myrddin-8283): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Jan 10 01:07:08 localhost gconfd (myrddin-8283): Resolved address "xml:readonly:/var/lib/gconf/debian.defaults" to a read-only configuration source at position 4
Jan 10 01:07:08 localhost gconfd (myrddin-8283): Resolved address "xml:readonly:/var/lib/gconf/defaults" to a read-only configuration source at position 5
Jan 10 01:07:10 localhost gconfd (myrddin-8283): Resolved address "xml:readwrite:/home/myrddin/.gconf" to a writable configuration source at position 0
Jan 10 01:20:32 localhost -- MARK --
Jan 10 01:40:32 localhost -- MARK --
Jan 10 02:00:32 localhost -- MARK --
Jan 10 02:20:32 localhost -- MARK --
Jan 10 02:40:32 localhost -- MARK --
Jan 10 03:00:32 localhost -- MARK --
Jan 10 03:20:32 localhost -- MARK --
Jan 10 03:40:32 localhost -- MARK --
Jan 10 04:00:32 localhost -- MARK --
Jan 10 04:20:32 localhost -- MARK --
Jan 10 04:40:32 localhost -- MARK --
Jan 10 05:00:32 localhost -- MARK --
Jan 10 05:20:32 localhost -- MARK --
Jan 10 05:40:32 localhost -- MARK --
Jan 10 06:00:32 localhost -- MARK --
Jan 10 06:20:32 localhost -- MARK --
Jan 10 06:40:32 localhost -- MARK --
Jan 10 07:00:32 localhost -- MARK --
Jan 10 07:20:32 localhost -- MARK --
Jan 10 07:40:32 localhost -- MARK --
Jan 10 08:00:32 localhost -- MARK --
Jan 10 08:20:32 localhost -- MARK --
Jan 10 08:25:50 localhost gconfd (myrddin-8283): Exiting
Jan 10 08:25:50 localhost gconfd (myrddin-19099): starting (version 2.16.0), pid 19099 user 'myrddin'
Jan 10 08:25:50 localhost gconfd (myrddin-19099): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Jan 10 08:25:50 localhost gconfd (myrddin-19099): Resolved address "xml:readwrite:/home/myrddin/.gconf" to a writable configuration source at position 1
Jan 10 08:25:50 localhost gconfd (myrddin-19099): Resolved address "xml:readonly:/usr/share/cdd/gconf.xml.defaults" to a read-only configuration source at position 2
Jan 10 08:25:50 localhost gconfd (myrddin-19099): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 3
Jan 10 08:25:50 localhost gconfd (myrddin-19099): Resolved address "xml:readonly:/var/lib/gconf/debian.defaults" to a read-only configuration source at position 4
Jan 10 08:25:50 localhost gconfd (myrddin-19099): Resolved address "xml:readonly:/var/lib/gconf/defaults" to a read-only configuration source at position 5
Jan 10 08:25:59 localhost shutdown[8121]: shutting down for system reboot
Jan 10 08:26:05 localhost kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Jan 10 08:26:05 localhost kernel: apm: disabled on user request.
Jan 10 08:26:19 localhost kernel: Kernel logging (proc) stopped.
Jan 10 08:26:19 localhost kernel: Kernel log daemon terminating.
Jan 10 08:26:20 localhost gconfd (myrddin-19099): GConf server is not in use, shutting down.
Jan 10 08:26:20 localhost gconfd (myrddin-19099): Exiting
Jan 10 08:26:20 localhost exiting on signal 15
Jan 10 08:27:32 localhost syslogd 1.4.1#18: restart.
Jan 10 08:27:32 localhost kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Jan 10 08:27:32 localhost kernel: 00   ( 759 MB)
Jan 10 08:27:32 localhost kernel:     lowmem  : 0xb0000000 - 0xcfff0000   ( 511 MB)
Jan 10 08:27:32 localhost kernel:       .init : 0xb0314000 - 0xb0340000   ( 176 kB)
Jan 10 08:27:32 localhost kernel:       .data : 0xb02880d5 - 0xb0311f94   ( 551 kB)
Jan 10 08:27:32 localhost kernel:       .text : 0xb0100000 - 0xb02880d5   (1568 kB)
Jan 10 08:27:32 localhost kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Jan 10 08:27:32 localhost kernel: Calibrating delay using timer specific routine.. 4008.13 BogoMIPS (lpj=2004067)
Jan 10 08:27:32 localhost kernel: Security Framework v1.0.0 initialized
Jan 10 08:27:32 localhost kernel: SELinux:  Disabled at boot.
Jan 10 08:27:32 localhost kernel: Capability LSM initialized
Jan 10 08:27:32 localhost kernel: Mount-cache hash table entries: 512
Jan 10 08:27:32 localhost kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jan 10 08:27:32 localhost kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jan 10 08:27:32 localhost kernel: Intel machine check architecture supported.
Jan 10 08:27:32 localhost kernel: Intel machine check reporting enabled on CPU#0.
Jan 10 08:27:32 localhost kernel: Compat vDSO mapped to ffffe000.
Jan 10 08:27:32 localhost kernel: CPU: AMD Sempron(tm)   2800+ stepping 00
Jan 10 08:27:32 localhost kernel: Checking 'hlt' instruction... OK.
Jan 10 08:27:32 localhost kernel: ACPI: Core revision 20060707
Jan 10 08:27:32 localhost kernel: ACPI: setting ELCR to 0200 (from 0e20)
Jan 10 08:27:32 localhost kernel: checking if image is initramfs... it is
Jan 10 08:27:32 localhost kernel: Freeing initrd memory: 4742k freed
Jan 10 08:27:32 localhost kernel: NET: Registered protocol family 16
Jan 10 08:27:32 localhost kernel: ACPI: bus type pci registered
Jan 10 08:27:32 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb2f0, last bus=1
Jan 10 08:27:32 localhost kernel: PCI: Using configuration type 1
Jan 10 08:27:32 localhost kernel: Setting up standard PCI resources
Jan 10 08:27:32 localhost kernel: ACPI: Interpreter enabled
Jan 10 08:27:32 localhost kernel: ACPI: Using PIC for interrupt routing
Jan 10 08:27:32 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jan 10 08:27:32 localhost kernel: PCI: MSI-K8T-Neo2Fir, attempting to turn soundcard ON
Jan 10 08:27:32 localhost kernel: PCI: MSI-K8T-Neo2Fir, soundcard on
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12)
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11 12)
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12) *5
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0, disabled.
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0, disabled.
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0, disabled.
Jan 10 08:27:32 localhost kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jan 10 08:27:32 localhost kernel: pnp: PnP ACPI init
Jan 10 08:27:32 localhost kernel: pnp: PnP ACPI: found 13 devices
Jan 10 08:27:32 localhost kernel: PnPBIOS: Disabled by ACPI PNP
Jan 10 08:27:32 localhost kernel: PCI: Using ACPI for IRQ routing
Jan 10 08:27:32 localhost kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Jan 10 08:27:32 localhost kernel: pnp: 00:02: ioport range 0x4000-0x407f could not be reserved
Jan 10 08:27:32 localhost kernel: pnp: 00:02: ioport range 0x40f0-0x40ff could not be reserved
Jan 10 08:27:32 localhost kernel: pnp: 00:02: ioport range 0x5000-0x500f has been reserved
Jan 10 08:27:32 localhost kernel: PCI: Bridge: 0000:00:01.0
Jan 10 08:27:32 localhost kernel:   IO window: disabled.
Jan 10 08:27:32 localhost kernel:   MEM window: e0000000-e1ffffff
Jan 10 08:27:32 localhost kernel:   PREFETCH window: d8000000-dfffffff
Jan 10 08:27:32 localhost kernel: NET: Registered protocol family 2
Jan 10 08:27:32 localhost kernel: IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
Jan 10 08:27:32 localhost kernel: TCP established hash table entries: 16384 (order: 7, 524288 bytes)
Jan 10 08:27:32 localhost kernel: TCP bind hash table entries: 8192 (order: 5, 229376 bytes)
Jan 10 08:27:32 localhost kernel: TCP: Hash tables configured (established 16384 bind 8192)
Jan 10 08:27:32 localhost kernel: TCP reno registered
Jan 10 08:27:32 localhost kernel: audit: initializing netlink socket (disabled)
Jan 10 08:27:32 localhost kernel: audit(1168417631.540:1): initialized
Jan 10 08:27:32 localhost kernel: VFS: Disk quotas dquot_6.5.1
Jan 10 08:27:32 localhost kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Jan 10 08:27:32 localhost kernel: io scheduler noop registered
Jan 10 08:27:32 localhost kernel: io scheduler anticipatory registered (default)
Jan 10 08:27:32 localhost kernel: io scheduler deadline registered
Jan 10 08:27:32 localhost kernel: io scheduler cfq registered
Jan 10 08:27:32 localhost kernel: isapnp: Scanning for PnP cards...
Jan 10 08:27:32 localhost kernel: isapnp: No Plug & Play device found
Jan 10 08:27:32 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Jan 10 08:27:32 localhost kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan 10 08:27:32 localhost kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jan 10 08:27:32 localhost kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Jan 10 08:27:32 localhost kernel: PNP: No PS/2 controller found. Probing ports directly.
Jan 10 08:27:32 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jan 10 08:27:32 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jan 10 08:27:32 localhost kernel: TCP bic registered
Jan 10 08:27:32 localhost kernel: NET: Registered protocol family 1
Jan 10 08:27:32 localhost kernel: NET: Registered protocol family 17
Jan 10 08:27:32 localhost kernel: NET: Registered protocol family 8
Jan 10 08:27:32 localhost kernel: NET: Registered protocol family 20
Jan 10 08:27:32 localhost kernel: Using IPI Shortcut mode
Jan 10 08:27:32 localhost kernel: ACPI: (supports S0 S1 S4 S5)
Jan 10 08:27:32 localhost kernel: Switched to high resolution mode on CPU 0
Jan 10 08:27:32 localhost kernel: Freeing unused kernel memory: 176k freed
Jan 10 08:27:32 localhost kernel: via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: eth0: VIA Rhine II at 0x1e000, 00:0f:ea:02:d9:a8, IRQ 11.
Jan 10 08:27:32 localhost kernel: eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
Jan 10 08:27:32 localhost kernel: usbcore: registered new interface driver usbfs
Jan 10 08:27:32 localhost kernel: usbcore: registered new interface driver hub
Jan 10 08:27:32 localhost kernel: usbcore: registered new device driver usb
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Jan 10 08:27:32 localhost kernel: ehci_hcd 0000:00:10.4: EHCI Host Controller
Jan 10 08:27:32 localhost kernel: ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
Jan 10 08:27:32 localhost kernel: ehci_hcd 0000:00:10.4: irq 10, io mem 0xe3036000
Jan 10 08:27:32 localhost kernel: ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Jan 10 08:27:32 localhost kernel: usb usb1: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: hub 1-0:1.0: USB hub found
Jan 10 08:27:32 localhost kernel: hub 1-0:1.0: 8 ports detected
Jan 10 08:27:32 localhost kernel: USB Universal Host Controller Interface driver v3.0
Jan 10 08:27:32 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jan 10 08:27:32 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 10 08:27:32 localhost kernel: SCSI subsystem initialized
Jan 10 08:27:32 localhost kernel: Fusion MPT base driver 3.04.02
Jan 10 08:27:32 localhost kernel: Copyright (c) 1999-2005 LSI Logic Corporation
Jan 10 08:27:32 localhost kernel: Fusion MPT FC Host driver 3.04.02
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:0a.2[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[e3035000-e30357ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.0: irq 11, io base 0x0000cc00
Jan 10 08:27:32 localhost kernel: usb usb2: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: hub 2-0:1.0: USB hub found
Jan 10 08:27:32 localhost kernel: hub 2-0:1.0: 2 ports detected
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.1: irq 11, io base 0x0000d000
Jan 10 08:27:32 localhost kernel: usb usb3: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: hub 3-0:1.0: USB hub found
Jan 10 08:27:32 localhost kernel: hub 3-0:1.0: 2 ports detected
Jan 10 08:27:32 localhost kernel: usb 1-4: new high speed USB device using ehci_hcd and address 2
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.2: irq 11, io base 0x0000d400
Jan 10 08:27:32 localhost kernel: usb usb4: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: hub 4-0:1.0: USB hub found
Jan 10 08:27:32 localhost kernel: hub 4-0:1.0: 2 ports detected
Jan 10 08:27:32 localhost kernel: usb 1-4: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: hub 1-4:1.0: USB hub found
Jan 10 08:27:32 localhost kernel: hub 1-4:1.0: 4 ports detected
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.3: UHCI Host Controller
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
Jan 10 08:27:32 localhost kernel: uhci_hcd 0000:00:10.3: irq 11, io base 0x0000d800
Jan 10 08:27:32 localhost kernel: usb usb5: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: hub 5-0:1.0: USB hub found
Jan 10 08:27:32 localhost kernel: hub 5-0:1.0: 2 ports detected
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: mptbase: mpt_adapter_install
Jan 10 08:27:32 localhost kernel: mptbase: mem = d0940000, mem_phys = e3000000
Jan 10 08:27:32 localhost kernel: mptbase: facts @ cfe1f2a4, pfacts[0] @ cfe1f2f4
Jan 10 08:27:32 localhost kernel: mptbase: Initiating ioc0 bringup
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: IOC operational unexpected
Jan 10 08:27:32 localhost kernel: mptbase: whoinit 0x2 statefault 0 force 0
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: Sending get IocFacts request req_sz=12 reply_sz=80
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: NB_for_64_byte_frame=2 NBShiftFactor=5 BlockSize=8
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: reply_sz= 80, reply_depth= 128
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: req_sz  =128, req_depth  =1023
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: Sending get PortFacts(0) request
Jan 10 08:27:32 localhost kernel: ioc0: FC909: Capabilities={Initiator,LAN}
Jan 10 08:27:32 localhost kernel: mptbase: ioc0 ReqToChain alloc  @ ced75000, sz=4092 bytes
Jan 10 08:27:32 localhost kernel: mptbase: ioc0 RequestNB alloc  @ cec4d000, sz=4092 bytes
Jan 10 08:27:32 localhost kernel: mptbase: ioc0 num_sge=25 numSGE=490
Jan 10 08:27:32 localhost kernel: mptbase: ioc0 Now numSGE=40 num_sge=40 num_chain=3
Jan 10 08:27:32 localhost kernel: mptbase: ioc0 ChainToChain alloc @ ced34800, sz=1524 bytes
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.ReplyBuffer sz=80 bytes, ReplyDepth=128
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.ReplyBuffer sz=10240[2800] bytes
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.RequestBuffer sz=128 bytes, RequestDepth=1023
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.RequestBuffer sz=130944[1ff80] bytes
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.ChainBuffer sz=128 bytes, ChainDepth=381
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.ChainBuffer sz=48768[be80] bytes num_chain=381
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.Total alloc @ cee00000[1ee00000], sz=189952[2e600] bytes
Jan 10 08:27:32 localhost kernel: mptbase: ioc0 ReplyBuffers @ cee00000[1ee00000]
Jan 10 08:27:32 localhost kernel: mptbase: ioc0 RequestBuffers @ cee02800[1ee02800]
Jan 10 08:27:32 localhost kernel: mptbase :ioc0 ChainBuffers @ cee22780(1ee22780)
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.SenseBuffers @ cedd0000[1edd0000]
Jan 10 08:27:32 localhost kernel: mptbase: ioc0.ReplyBuffers @ cee00000[1ee00000]
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: facts.MsgVersion=100
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: Sending Port(0)Enable (req @ cf21bc20)
Jan 10 08:27:32 localhost kernel: mptbase: ioc0: INFO - Wait IOC_OPERATIONAL state (cnt=0)
Jan 10 08:27:32 localhost kernel: scsi0 : ioc0: LSIFC909, FwRev=01000000h, Ports=1, MaxQ=1023, IRQ=11
Jan 10 08:27:32 localhost kernel: VP_IDE: IDE controller at PCI slot 0000:00:0f.0
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: PCI: VIA IRQ fixup for 0000:00:0f.0, from 255 to 11
Jan 10 08:27:32 localhost kernel: VP_IDE: chipset revision 6
Jan 10 08:27:32 localhost kernel: VP_IDE: not 100%% native mode: will probe irqs later
Jan 10 08:27:32 localhost kernel: VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.0
Jan 10 08:27:32 localhost kernel:     ide0: BM-DMA at 0xc800-0xc807, BIOS settings: hda:DMA, hdb:DMA
Jan 10 08:27:32 localhost kernel:     ide1: BM-DMA at 0xc808-0xc80f, BIOS settings: hdc:DMA, hdd:pio
Jan 10 08:27:32 localhost kernel: hda: WDC WD1200JB-00GVC0, ATA DISK drive
Jan 10 08:27:32 localhost kernel: usb 1-4.3: new low speed USB device using ehci_hcd and address 4
Jan 10 08:27:32 localhost kernel: usb 1-4.3: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: hdb: TSSTcorpCD/DVDW SH-S182M, ATAPI CD/DVD-ROM drive
Jan 10 08:27:32 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 10 08:27:32 localhost kernel: usb 1-4.4: new full speed USB device using ehci_hcd and address 5
Jan 10 08:27:32 localhost kernel: usb 1-4.4: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: Initializing USB Mass Storage driver...
Jan 10 08:27:32 localhost kernel: hdc: WDC WD307AA, ATA DISK drive
Jan 10 08:27:32 localhost kernel: usb 5-2: new full speed USB device using uhci_hcd and address 2
Jan 10 08:27:32 localhost kernel: usb 5-2: configuration #1 chosen from 1 choice
Jan 10 08:27:32 localhost kernel: usbcore: registered new interface driver hiddev
Jan 10 08:27:32 localhost kernel: input: Gyration GyroPoint RF Technology Receiver as /class/input/input0
Jan 10 08:27:32 localhost kernel: input: USB HID v1.00 Keyboard [Gyration GyroPoint RF Technology Receiver] on usb-0000:00:10.4-4.3
Jan 10 08:27:32 localhost kernel: input: Gyration GyroPoint RF Technology Receiver as /class/input/input1
Jan 10 08:27:32 localhost kernel: input,hiddev96: USB HID v1.00 Mouse [Gyration GyroPoint RF Technology Receiver] on usb-0000:00:10.4-4.3
Jan 10 08:27:32 localhost kernel: usbcore: registered new interface driver usbhid
Jan 10 08:27:32 localhost kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Jan 10 08:27:32 localhost kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Jan 10 08:27:32 localhost kernel: usbcore: registered new interface driver usb-storage
Jan 10 08:27:32 localhost kernel: USB Mass Storage support registered.
Jan 10 08:27:32 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan 10 08:27:32 localhost kernel: hda: max request size: 512KiB
Jan 10 08:27:32 localhost kernel: hda: Host Protected Area detected.
Jan 10 08:27:32 localhost kernel: ^Icurrent capacity is 234439535 sectors (120033 MB)
Jan 10 08:27:32 localhost kernel: ^Inative  capacity is 234441648 sectors (120034 MB)
Jan 10 08:27:32 localhost kernel: hda: Host Protected Area disabled.
Jan 10 08:27:32 localhost kernel: hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(33)
Jan 10 08:27:32 localhost kernel: hda: cache flushes supported
Jan 10 08:27:32 localhost kernel:  hda: hda1 hda2 hda3 < hda5 >
Jan 10 08:27:32 localhost kernel: hdc: max request size: 128KiB
Jan 10 08:27:32 localhost kernel: hdb: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Jan 10 08:27:32 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Jan 10 08:27:32 localhost kernel: hdc: Host Protected Area detected.
Jan 10 08:27:32 localhost kernel: ^Icurrent capacity is 60072671 sectors (30757 MB)
Jan 10 08:27:32 localhost kernel: ^Inative  capacity is 60074784 sectors (30758 MB)
Jan 10 08:27:32 localhost kernel: hdc: Host Protected Area disabled.
Jan 10 08:27:32 localhost kernel: hdc: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=59598/16/63, UDMA(66)
Jan 10 08:27:32 localhost kernel: hdc: cache flushes not supported
Jan 10 08:27:32 localhost kernel:  hdc: hdc1
Jan 10 08:27:32 localhost kernel: Attempting manual resume
Jan 10 08:27:32 localhost kernel: kjournald starting.  Commit interval 5 seconds
Jan 10 08:27:32 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jan 10 08:27:32 localhost kernel: parport: PnPBIOS parport detected.
Jan 10 08:27:32 localhost kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Jan 10 08:27:32 localhost kernel: 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jan 10 08:27:32 localhost kernel: 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Jan 10 08:27:32 localhost kernel: scsi 1:0:0:0: Direct-Access     HP       psc 2410         1.00 PQ: 0 ANSI: 2
Jan 10 08:27:32 localhost kernel: Bluetooth: Core ver 2.11
Jan 10 08:27:32 localhost kernel: NET: Registered protocol family 31
Jan 10 08:27:32 localhost kernel: Bluetooth: HCI device and connection manager initialized
Jan 10 08:27:32 localhost kernel: Bluetooth: HCI socket layer initialized
Jan 10 08:27:32 localhost kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 5 if 1 alt 0 proto 2 vid 0x03F0 pid 0x3611
Jan 10 08:27:32 localhost kernel: usbcore: registered new interface driver usblp
Jan 10 08:27:32 localhost kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Jan 10 08:27:32 localhost kernel: input: PC Speaker as /class/input/input2
Jan 10 08:27:32 localhost kernel: mice: PS/2 mouse device common for all mice
Jan 10 08:27:32 localhost kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jan 10 08:27:32 localhost kernel: eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Jan 10 08:27:32 localhost kernel: Real Time Clock Driver v1.12ac
Jan 10 08:27:32 localhost kernel: Floppy drive(s): fd0 is 1.44M
Jan 10 08:27:32 localhost kernel: gameport: NS558 PnP Gameport is pnp00:0c/gameport0, io 0x201, speed 946kHz
Jan 10 08:27:32 localhost kernel: FDC 0 is a post-1991 82077
Jan 10 08:27:32 localhost kernel: Bluetooth: HCI USB driver ver 2.9
Jan 10 08:27:32 localhost kernel: Linux video capture interface: v2.00
Jan 10 08:27:32 localhost kernel: usbcore: registered new interface driver hci_usb
Jan 10 08:27:32 localhost kernel: agpgart: Detected VIA KT400/KT400A/KT600 chipset
Jan 10 08:27:32 localhost kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Jan 10 08:27:32 localhost kernel: saa7130/34: v4l2 driver version 0.2.14 loaded
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:27:32 localhost kernel: saa7133[0]: found at 0000:00:0b.0, rev: 16, irq: 11, latency: 32, mmio: 0xe3034000
Jan 10 08:27:32 localhost kernel: saa7133[0]: subsystem: 1043:4843, board: ASUS TV-FM 7133 [card=25,autodetected]
Jan 10 08:27:32 localhost kernel: saa7133[0]: board init: gpio is 0
Jan 10 08:27:32 localhost kernel: sd 1:0:0:0: Attached scsi removable disk sda
Jan 10 08:27:32 localhost kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Jan 10 08:27:32 localhost kernel: saa7133[0]: i2c eeprom 00: 43 10 43 48 ff ff ff ff ff ff ff ff ff ff ff ff
Jan 10 08:27:32 localhost kernel: saa7133[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Jan 10 08:27:32 localhost kernel: saa7133[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Jan 10 08:27:32 localhost kernel: saa7133[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Jan 10 08:27:32 localhost kernel: saa7133[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Jan 10 08:27:32 localhost kernel: saa7133[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Jan 10 08:27:32 localhost kernel: saa7133[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Jan 10 08:27:32 localhost kernel: saa7133[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
Jan 10 08:27:32 localhost kernel: tuner 0-0043: chip found @ 0x86 (saa7133[0])
Jan 10 08:27:32 localhost kernel: tda9887 0-0043: tda988[5/6/7] found @ 0x43 (tuner)
Jan 10 08:27:32 localhost kernel: tuner 0-0060: All bytes are equal. It is not a TEA5767
Jan 10 08:27:32 localhost kernel: tuner 0-0060: chip found @ 0xc0 (saa7133[0])
Jan 10 08:27:32 localhost kernel: tuner 0-0060: type set to 43 (Philips NTSC MK3 (FM1236MK3 or FM1236/F))
Jan 10 08:27:32 localhost kernel: tuner 0-0060: type set to 43 (Philips NTSC MK3 (FM1236MK3 or FM1236/F))
Jan 10 08:27:32 localhost kernel: saa7133[0]: registered device video0 [v4l2]
Jan 10 08:27:32 localhost kernel: saa7133[0]: registered device vbi0
Jan 10 08:27:32 localhost kernel: saa7133[0]: registered device radio0
Jan 10 08:27:32 localhost kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Jan 10 08:27:32 localhost kernel: Installing spdif_bug patch: Audigy 2 ZS [SB0353]
Jan 10 08:27:32 localhost kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Jan 10 08:27:32 localhost kernel: Adding 497952k swap on /dev/hda5.  Priority:-1 extents:1 across:497952k
Jan 10 08:27:32 localhost kernel: EXT3 FS on hda2, internal journal
Jan 10 08:27:32 localhost kernel: it87: Found IT8705F chip at 0x290, revision 3
Jan 10 08:27:32 localhost kernel: it87-isa 9191-0290: Detected broken BIOS defaults, disabling PWM interface
Jan 10 08:27:32 localhost kernel: device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
Jan 10 08:27:32 localhost kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
Jan 10 08:27:32 localhost kernel: NET: Registered protocol family 10
Jan 10 08:27:32 localhost kernel: lo: Disabled Privacy Extensions
Jan 10 08:27:33 localhost ptal-mlcd: SYSLOG at ExMgr.cpp:652, dev=<mlc:usb:psc_2400_series>, pid=4335, e=2, t=1168435653         ptal-mlcd successfully initialized. 
Jan 10 08:27:33 localhost ptal-printd: ptal-printd(mlc:usb:psc_2400_series) successfully initialized using /var/run/ptal-printd/mlc_usb_psc_2400_series*. 
Jan 10 08:27:35 localhost ptal-photod: ptal-photod(mlc:usb:psc_2400_series) successfully initialized, listening on port 5703. 
Jan 10 08:27:36 localhost kernel: lp0: using parport0 (interrupt-driven).
Jan 10 08:27:36 localhost kernel: ppdev: user-space parallel port driver

--=-Hmvrz213OdcutZ4j6OWd--

