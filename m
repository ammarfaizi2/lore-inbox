Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSHXAGw>; Fri, 23 Aug 2002 20:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSHXAGw>; Fri, 23 Aug 2002 20:06:52 -0400
Received: from ip29.xiotech.com ([209.46.118.29]:38661 "EHLO
	pdamail.xiotech.com") by vger.kernel.org with ESMTP
	id <S314396AbSHXAGr>; Fri, 23 Aug 2002 20:06:47 -0400
Message-ID: <ED8EDD517E0AA84FA2C36C8D6D205C1303F1C300@alfred.xiotech.com>
From: "Brueggeman, Steve" <steve_brueggeman@xiotech.com>
To: "'Grover, Andrew'" <andrew.grover@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Anyone know how to get soft-power-down to work on an Intel SC
	 B2??
Date: Fri, 23 Aug 2002 19:10:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmsg output (head appears to be cut off)
<==============================================>
ries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfda75, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router default [1166/0201] at 00:0f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
mxt_scan_bios: enter
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.5.0 initialized
ACPI: Core Subsystem version [20010615]
ACPI: Subsystem enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: queued sectors max/low 338472kB/207400kB, 1024 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz PCI bus speed for PIO modes; override with idebus=xx
ServerWorks CSB5: IDE controller on PCI bus 00 dev 79
PCI: Device 00:0f.1 not available because of resource collisions
ServerWorks CSB5: chipset revision 146
ServerWorks CSB5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/255 SCBs

blk: queue c1c1f818, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c1c1f818, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST318406LC        Rev: 0109
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c1bfc818, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST318406LC        Rev: 0109
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c1bfcc18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: ESG-SHV   Model: SCA HSBP M16      Rev: 0.04
  Type:   Processor                          ANSI SCSI revision: 02
blk: queue c1bc8818, I/O limit 4095Mb (mask 0xffffffff)
scsi1:0:0:0: Tagged Queuing enabled.  Depth 253
scsi1:0:1:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
(read) sda1's sb offset: 48064 [events: 0000000a]
(read) sda2's sb offset: 3486016 [events: 0000000a]
(read) sda3's sb offset: 11486400 [events: 0000000a]
(read) sda5's sb offset: 1228864 [events: 0000000a]
(read) sda6's sb offset: 1220800 [events: 0000000a]
(read) sda7's sb offset: 449664 [events: 0000000a]
(read) sdb1's sb offset: 48064 [events: 0000000a]
(read) sdb2's sb offset: 3486016 [events: 0000000a]
(read) sdb3's sb offset: 11486400 [events: 0000000a]
(read) sdb5's sb offset: 1228864 [events: 0000000a]
(read) sdb6's sb offset: 1220800 [events: 0000000a]
(read) sdb7's sb offset: 449664 [events: 0000000a]
md: autorun ...
md: considering sdb7 ...
md:  adding sdb7 ...
md:  adding sda7 ...
md: created md5
md: bind<sda7,1>
md: bind<sdb7,2>
md: running: <sdb7><sda7>
md: sdb7's event counter: 0000000a
md: sda7's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
request_module[md-personality-3]: Root fs not mounted
md.c: personality 3 is not loaded!
md :do_md_run() returned -22
md: md5 stopped.
md: unbind<sdb7,1>
md: export_rdev(sdb7)
md: unbind<sda7,0>
md: export_rdev(sda7)
md: considering sdb6 ...
md:  adding sdb6 ...
md:  adding sda6 ...
md: created md4
md: bind<sda6,1>
md: bind<sdb6,2>
md: running: <sdb6><sda6>
md: sdb6's event counter: 0000000a
md: sda6's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
request_module[md-personality-3]: Root fs not mounted
md.c: personality 3 is not loaded!
md :do_md_run() returned -22
md: md4 stopped.
md: unbind<sdb6,1>
md: export_rdev(sdb6)
md: unbind<sda6,0>
md: export_rdev(sda6)
md: considering sdb5 ...
md:  adding sdb5 ...
md:  adding sda5 ...
md: created md3
md: bind<sda5,1>
md: bind<sdb5,2>
md: running: <sdb5><sda5>
md: sdb5's event counter: 0000000a
md: sda5's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
request_module[md-personality-3]: Root fs not mounted
md.c: personality 3 is not loaded!
md :do_md_run() returned -22
md: md3 stopped.
md: unbind<sdb5,1>
md: export_rdev(sdb5)
md: unbind<sda5,0>
md: export_rdev(sda5)
md: considering sdb3 ...
md:  adding sdb3 ...
md:  adding sda3 ...
md: created md2
md: bind<sda3,1>
md: bind<sdb3,2>
md: running: <sdb3><sda3>
md: sdb3's event counter: 0000000a
md: sda3's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
request_module[md-personality-3]: Root fs not mounted
md.c: personality 3 is not loaded!
md :do_md_run() returned -22
md: md2 stopped.
md: unbind<sdb3,1>
md: export_rdev(sdb3)
md: unbind<sda3,0>
md: export_rdev(sda3)
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md1
md: bind<sda2,1>
md: bind<sdb2,2>
md: running: <sdb2><sda2>
md: sdb2's event counter: 0000000a
md: sda2's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
request_module[md-personality-3]: Root fs not mounted
md.c: personality 3 is not loaded!
md :do_md_run() returned -22
md: md1 stopped.
md: unbind<sdb2,1>
md: export_rdev(sdb2)
md: unbind<sda2,0>
md: export_rdev(sda2)
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1,1>
md: bind<sdb1,2>
md: running: <sdb1><sda1>
md: sdb1's event counter: 0000000a
md: sda1's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
request_module[md-personality-3]: Root fs not mounted
md.c: personality 3 is not loaded!
md :do_md_run() returned -22
md: md0 stopped.
md: unbind<sdb1,1>
md: export_rdev(sdb1)
md: unbind<sda1,0>
md: export_rdev(sda1)
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 372k freed
VFS: Mounted root (ext2 filesystem).
md: raid1 personality registered as nr 3
Journalled Block Device driver loaded
md: Autodetecting RAID arrays.
(read) sdb7's sb offset: 449664 [events: 0000000a]
(read) sda7's sb offset: 449664 [events: 0000000a]
(read) sdb6's sb offset: 1220800 [events: 0000000a]
(read) sda6's sb offset: 1220800 [events: 0000000a]
(read) sdb5's sb offset: 1228864 [events: 0000000a]
(read) sda5's sb offset: 1228864 [events: 0000000a]
(read) sdb3's sb offset: 11486400 [events: 0000000a]
(read) sda3's sb offset: 11486400 [events: 0000000a]
(read) sdb2's sb offset: 3486016 [events: 0000000a]
(read) sda2's sb offset: 3486016 [events: 0000000a]
(read) sdb1's sb offset: 48064 [events: 0000000a]
(read) sda1's sb offset: 48064 [events: 0000000a]
md: autorun ...
md: considering sda1 ...
md:  adding sda1 ...
md:  adding sdb1 ...
md: created md0
md: bind<sdb1,1>
md: bind<sda1,2>
md: running: <sda1><sdb1>
md: sda1's event counter: 0000000a
md: sdb1's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device sda1 operational as mirror 0
raid1: device sdb1 operational as mirror 1
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
md: sda1 [events: 0000000b](write) sda1's sb offset: 48064
md: sdb1 [events: 0000000b](write) sdb1's sb offset: 48064
md: considering sda2 ...
md:  adding sda2 ...
md:  adding sdb2 ...
md: created md1
md: bind<sdb2,1>
md: bind<sda2,2>
md: running: <sda2><sdb2>
md: sda2's event counter: 0000000a
md: sdb2's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device sda2 operational as mirror 0
raid1: device sdb2 operational as mirror 1
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
md: sda2 [events: 0000000b](write) sda2's sb offset: 3486016
md: sdb2 [events: 0000000b](write) sdb2's sb offset: 3486016
md: considering sda3 ...
md:  adding sda3 ...
md:  adding sdb3 ...
md: created md2
md: bind<sdb3,1>
md: bind<sda3,2>
md: running: <sda3><sdb3>
md: sda3's event counter: 0000000a
md: sdb3's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
md2: max total readahead window set to 124k
md2: 1 data-disks, max readahead per data-disk: 124k
raid1: device sda3 operational as mirror 0
raid1: device sdb3 operational as mirror 1
raid1: raid set md2 active with 2 out of 2 mirrors
md: updating md2 RAID superblock on device
md: sda3 [events: 0000000b](write) sda3's sb offset: 11486400
md: sdb3 [events: 0000000b](write) sdb3's sb offset: 11486400
md: considering sda5 ...
md:  adding sda5 ...
md:  adding sdb5 ...
md: created md3
md: bind<sdb5,1>
md: bind<sda5,2>
md: running: <sda5><sdb5>
md: sda5's event counter: 0000000a
md: sdb5's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
md3: max total readahead window set to 124k
md3: 1 data-disks, max readahead per data-disk: 124k
raid1: device sda5 operational as mirror 0
raid1: device sdb5 operational as mirror 1
raid1: raid set md3 active with 2 out of 2 mirrors
md: updating md3 RAID superblock on device
md: sda5 [events: 0000000b](write) sda5's sb offset: 1228864
md: sdb5 [events: 0000000b](write) sdb5's sb offset: 1228864
md: considering sda6 ...
md:  adding sda6 ...
md:  adding sdb6 ...
md: created md4
md: bind<sdb6,1>
md: bind<sda6,2>
md: running: <sda6><sdb6>
md: sda6's event counter: 0000000a
md: sdb6's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
md4: max total readahead window set to 124k
md4: 1 data-disks, max readahead per data-disk: 124k
raid1: device sda6 operational as mirror 0
raid1: device sdb6 operational as mirror 1
raid1: raid set md4 active with 2 out of 2 mirrors
md: updating md4 RAID superblock on device
md: sda6 [events: 0000000b](write) sda6's sb offset: 1220800
md: sdb6 [events: 0000000b](write) sdb6's sb offset: 1220800
md: considering sda7 ...
md:  adding sda7 ...
md:  adding sdb7 ...
md: created md5
md: bind<sdb7,1>
md: bind<sda7,2>
md: running: <sda7><sdb7>
md: sda7's event counter: 0000000a
md: sdb7's event counter: 0000000a
RAID level 1 does not need chunksize! Continuing anyway.
md5: max total readahead window set to 124k
md5: 1 data-disks, max readahead per data-disk: 124k
raid1: device sda7 operational as mirror 0
raid1: device sdb7 operational as mirror 1
raid1: raid set md5 active with 2 out of 2 mirrors
md: updating md5 RAID superblock on device
md: sda7 [events: 0000000b](write) sda7's sb offset: 449664
md: sdb7 [events: 0000000b](write) sdb7's sb offset: 449664
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 204k freed
Adding Swap: 449656k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Guessed IRQ 10 for device 00:0f.2
PCI: Sharing IRQ 10 with 00:0f.3
usb-ohci.c: USB OHCI at membase 0xe0877000, IRQ 10
usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 4 ports detected
EXT3 FS 2.4-0.9.11, 3 Oct 2001 on sd(8,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.11, 3 Oct 2001 on md(9,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.11, 3 Oct 2001 on md(9,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.11, 3 Oct 2001 on md(9,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.11, 3 Oct 2001 on md(9,4), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:03:47:D5:6E:90, IRQ 10.
  Board assembly fab600-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
eth1: OEM i82557/i82558 10/100 Ethernet, 00:03:47:D5:6E:91, IRQ 5.
  Board assembly fab600-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
<==============================================>



-----Original Message-----
From: Grover, Andrew [mailto:andrew.grover@intel.com]
Sent: Friday, August 23, 2002 6:57 PM
To: 'Brueggeman, Steve'; 'linux-kernel@vger.kernel.org'
Subject: RE: Anyone know how to get soft-power-down to work on an Intel
SC B2??


> From: Brueggeman, Steve [mailto:steve_brueggeman@xiotech.com] 
> Their documentation says they support soft-power-off, but I 
> certainly cannot
> figure out how to do it.
> 
> The SCB2 only has one processor, and the kernel is compiled for single
> processor.   I've enabled APM and ACPI, and the exact same 
> binaries (kernel
> and modules) work on 4 different machines, and do 
> soft-power-off them, and
> one of them WAS a dual processor system.
> 
> So, I'm hoping that someone out there has figured out this problem.
> 
> I've even tried the patches for acpi on sourceforge.net.  
> They didn't help,
> and seemed to make the kernel MUCH more flakey (got illegal ioctl when
> trying to mount a loopback device)

We talking 2.4 or 2.5 here?

Please send me the output from dmesg. I have an SCB2 sitting 15 feet away
from me and haven't seen the problems you're running into.

> I'd appreciate it if you copied me on any responses, as I 
> currently am not
> subscribed to the kernel mailing list, (because I don't have 
> POP/SMTP access
> at work.  (M.S. Exchange house and all....)

Well I have to use Exchange, and I get about 10 mailing lists, so it is
possible.

Regards -- Andy
