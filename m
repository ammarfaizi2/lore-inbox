Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266881AbUHSRtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266881AbUHSRtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUHSRtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:49:35 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:52106 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S266881AbUHSRqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:46:06 -0400
Date: Thu, 19 Aug 2004 19:46:14 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1-mm2: floppy magically disappaperd
Message-ID: <20040819174614.GA23294@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


 Hi,

 My flopped disappeared with this kernel becaouse of ACPI. It was
working earlier revisions. Modprobing floppy.ko fails:

(in dmesg)
#v+
inserting floppy driver for 2.6.8.1-mm2
floppy: controller ACPI FDC0 at I/O 0x3f7-0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
floppy0: Floppy io-port 0x03f7 in use
#v-

 I am sending couple of files as report, please ping me if more
 information is needed.

-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.


--X1bOJ3K7DJ5YkBrT
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.8.1-mm2 (zdzichu@mother) (gcc version 3.4.1) #4 Thu Aug 19 15:08:26 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI: RSDP (v000 VIA693                                    ) @ 0x000f70c0
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: DSDT (v001 VIA693 AWRDACPI 0x00001000 MSFT 0x0100000a) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda4 acpi=force ro elevator=cfq resume=/dev/hda2 
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 367.592 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 254920k/262080k available (2605k kernel code, 6608k reserved, 965k data, 160k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 718.84 BogoMIPS (lpj=359424)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps:        0183f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbed0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbef8, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
vesafb: probe of vesafb0 failed with error -6
audit: initializing netlink socket (disabled)
audit(1092921402.4294965890:0): initialized
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 133 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe0000000
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox Graphics, Inc. MGA G550 AGP
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST380011A, ATA DISK drive
hda: IRQ probe failed (0xfcfa)
hdb: IRQ probe failed (0xfcfa)
hdb: IRQ probe failed (0xfcfa)
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
hdc: 8X4X32, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(66)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 (level, low) -> IRQ 10
ALSA device list:
  #0: Ensoniq AudioPCI ENS1370 at 0xdc00, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 296 bytes per conntrack
ip_nat_irc: error registering helper for port 0
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
ACPI: (supports S0 S1 S4 S4bios S5)
ACPI wakeup devices: 
PWRB USB0 USB1 
ReiserFS: hda4: found reiserfs format "3.6" with standard journal
ReiserFS: hda4: using ordered data mode
ReiserFS: hda4: journal params: device hda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda4: checking transaction log (hda4)
ReiserFS: hda4: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 262136k swap on /dev/hda2.  Priority:2 extents:1
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
bttv0: Bt878 (rev 2) at 0000:00:09.0, irq: 11, latency: 32, mmio: 0xeb041000
bttv0: detected: AVerMedia TVCapture 98 [card=13], PCI subsystem ID is 1461:0004
bttv0: using: AVerMedia TVCapture 98 [card=13,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=001c7ff3 [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [11]
bttv0: Avermedia eeprom[0x4021]: tuner=5 radio:no remote control:yes
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for MSP34xx (alternate address) @ 0x88... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: Ignoring new-style parameters in presence of obsolete ones
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
tuner: Ignoring new-style parameters in presence of obsolete ones
tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt878 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: add subdevice "remote0"
ir-kbd-gpio: bttv IR (card=13) detected at pci-0000:00:09.0/ir0
cdrom: open failed.
ReiserFS: loop7: found reiserfs format "3.6" with standard journal
ReiserFS: loop7: using journaled data mode
ReiserFS: loop7: journal params: device loop7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: loop7: checking transaction log (loop7)
ReiserFS: loop7: Using r5 hash to sort names
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_validate_option: Checksum Offload Enabled
e1000: eth0: e1000_validate_option: Flow Control Enabled
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xd0a14000, 00:06:4f:00:e8:99, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
Disabled Privacy Extensions on device c0431100(lo)
e1000: ep0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
Disabled Privacy Extensions on device cf32ac00(sxb0)
ACPI: PCI interrupt 0000:00:09.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:07.5 to 64
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0000c400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: irq 10, io base 0000c800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth0: e1000_validate_option: Checksum Offload Enabled
e1000: eth0: e1000_validate_option: Flow Control Enabled
e1000: ep0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: ep0: e1000_watchdog: NIC Link is Down
e1000: ep0: e1000_watchdog: NIC Link is Up 10 Mbps Half Duplex
e1000: ep0: e1000_watchdog: NIC Link is Down
e1000: ep0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
device ep0 entered promiscuous mode
device ep0 left promiscuous mode
inserting floppy driver for 2.6.8.1-mm2
floppy: controller ACPI FDC0 at I/O 0x3f7-0x3f7 irq 6 dma channel 2
Floppy drive(s): fd0 is 1.44M
floppy0: Floppy io-port 0x03f7 in use

--X1bOJ3K7DJ5YkBrT
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="dmidecode.txt.gz"
Content-Transfer-Encoding: base64

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

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="interrupts.txt"

           CPU0       
  0:   16106216          XT-PIC  timer
  1:      31199          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:         26          XT-PIC  serial
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:    3019776          XT-PIC  Ensoniq AudioPCI, VIA686A, uhci_hcd, uhci_hcd, ep0
 11:     952856          XT-PIC  bttv0, Bt87x audio, mga@PCI:1:0:0
 12:     210614          XT-PIC  i8042
 14:     236596          XT-PIC  ide0
 15:     152034          XT-PIC  ide1
NMI:          0 
ERR:          0

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iomem.txt"

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c8fff : Video ROM
000d0000-000d17ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0038b583 : Kernel code
  0038b584-0047ccbf : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e7ffffff : PCI Bus #01
  e4000000-e4003fff : 0000:01:00.0
  e5000000-e57fffff : 0000:01:00.0
e8000000-e9ffffff : PCI Bus #01
  e8000000-e9ffffff : 0000:01:00.0
eb000000-eb01ffff : 0000:00:0c.0
  eb000000-eb01ffff : e1000
eb020000-eb03ffff : 0000:00:0c.0
  eb020000-eb03ffff : e1000
eb040000-eb0400ff : 0000:00:08.0
  eb040000-eb0400ff : 8139too
eb041000-eb041fff : 0000:00:09.0
  eb041000-eb041fff : bttv0
eb042000-eb042fff : 0000:00:09.1
  eb042000-eb042fff : Bt87x audio
ffff0000-ffffffff : reserved

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ioports.txt"

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-4003 : PM1a_EVT_BLK
4004-4005 : PM1a_CNT_BLK
4008-400b : PM_TMR
4010-4015 : ACPI CPU throttle
4020-4023 : GPE0_BLK
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
  6000-607f : via686a-sensor
c000-c00f : 0000:00:07.1
  c000-c007 : ide0
  c008-c00f : ide1
c400-c41f : 0000:00:07.2
  c400-c41f : uhci_hcd
c800-c81f : 0000:00:07.3
  c800-c81f : uhci_hcd
cc00-ccff : 0000:00:07.5
  cc00-ccff : VIA686A
d000-d003 : 0000:00:07.5
  d000-d003 : VIA686A
d400-d403 : 0000:00:07.5
  d400-d403 : VIA686A
d800-d8ff : 0000:00:08.0
  d800-d8ff : 8139too
dc00-dc3f : 0000:00:0b.0
  dc00-dc3f : Ensoniq AudioPCI
e000-e03f : 0000:00:0c.0
  e000-e03f : e1000

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.vvv.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 44)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: e8000000-e9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 1b)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at c000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 0e) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 0e) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 20)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 21)
	Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at cc00 [size=256]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at d400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at eb040000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Subsystem: Avermedia Technologies Inc AVerTV WDM Video Capture
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at eb041000 (32-bit, prefetchable) [size=4K]

00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: Avermedia Technologies Inc AVerTV WDM Audio Capture
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at eb042000 (32-bit, prefetchable) [size=4K]

00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
	Subsystem: Unknown device 4942:4c4c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [size=64]

00:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at eb020000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at eb000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at e000 [size=64]
	Expansion ROM at ea000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=8 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2


--X1bOJ3K7DJ5YkBrT--
