Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSILJDK>; Thu, 12 Sep 2002 05:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSILJDK>; Thu, 12 Sep 2002 05:03:10 -0400
Received: from ulima.unil.ch ([130.223.144.143]:34439 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S314396AbSILJDG>;
	Thu, 12 Sep 2002 05:03:06 -0400
Date: Thu, 12 Sep 2002 11:07:55 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.34 don't find my root (aic7xxx or ???)
Message-ID: <20020912090755.GA5890@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux version 2.5.34 (greg@localhost.localdomain) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #2 Wed Sep 11 21:03:41 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb900
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages
  Normal zone: 126960 pages
  HighMem zone: 0 pages
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: I845E        APIC at: 0xFEE00000
Processor #0 15:2 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Processors: 1
Kernel command line: BOOT_IMAGE=2.5.34 rw root=812 video=matrox:1600x1200-16@75 console=ttyS1
Initializing CPU#0
Detected 2221.196 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4374.52 BogoMIPS
Memory: 515996k/524224k available (1688k kernel code, 7840k reserved, 385k data, 296k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel 00/02 stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2220.0472 MHz.
..... host bus clock speed is 100.0930 MHz.
cpu: 0, clocks: 100930, slice: 50465
CPU0<T0:100928,T1:50448,D:15,S:50465,C:100930>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=3
PCI: Using configuration type 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
usb.c: registered new driver usbfs
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router default [8086/24c0] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B3,I0,P0) -> 16
PCI->APIC IRQ transform: (B3,I1,P0) -> 17
PCI->APIC IRQ transform: (B3,I2,P0) -> 18
PCI->APIC IRQ transform: (B3,I3,P0) -> 19
PCI->APIC IRQ transform: (B3,I4,P0) -> 16
PCI->APIC IRQ transform: (B3,I8,P0) -> 20
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
BIO: pool
 of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
aio_setup: sizeof(struct page) = 40
devfs: v1.21 (20020820) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Capability LSM initialized
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/%d0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/%d1 at I/O 0x2f8 (irq = 3) is a 16550A
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xDC000000, mapped to 0xe0805000, size 33554432
Console: switching to colour frame buffer device 200x75
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
i810_rng: RNG not detected
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on Intel i845 @ 0xe0000000 64MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
block: 256 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L120AVVA07-0, ATA DISK drive
blk: queue c038e164, I/O limit 4095Mb (mask 0xffffffff)
hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=15017/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R04
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: PIONEER   Model: CD-ROM DR-U06S    Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi1:A:15): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
(scsi1:A:15): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
scsi1:A:15:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 15, lun 0
SCSI device sda: 17850000 512-byte hdwr sectors (9139 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1 p2
SCSI device sdb: 71687370 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host1/bus0/target15/
lun0: p1 p2
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 3, lun 0
Attached scsi CD-ROM sr3 at scsi0, channel 0, id 4, lun 0
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
sr2: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
sr3: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
matroxfb_crtc2: secondary head of fb0 was registered as fb1
input: PS2++ Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
CAPI Subsystem Rev 1.21.6.8
capi20: started up with major 68
capi20: Rev 1.1.4.1.2.2: started up with major 68 (middleware+capifs)
capifs: Rev 1.14.6.8
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Cannot open root device "812" or 08:12
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:12
 <6>SysRq : Resetting

Any idea what I should do?
The same lilo config with 2.4.x-ac runs just fine ;-)

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
