Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319326AbSHVLqE>; Thu, 22 Aug 2002 07:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319327AbSHVLqE>; Thu, 22 Aug 2002 07:46:04 -0400
Received: from B5b76.pppool.de ([213.7.91.118]:63978 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S319326AbSHVLp5>; Thu, 22 Aug 2002 07:45:57 -0400
Subject: Re: 2.4.20-pre2-ac5 Promise PDC20269
From: Daniel Egger <degger@fhm.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029942175.26411.83.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208201845060.10173-100000@valhalla.homelinux.org> 
	<1029937618.26533.32.camel@irongate.swansea.linux.org.uk> 
	<1029938753.3800.2.camel@sonja.de.interearth.com> 
	<1029942175.26411.83.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-v7AV/6fmBdEtC/oCap8V"
X-Mailer: Ximian Evolution 1.0.7 
Date: 22 Aug 2002 13:53:56 +0200
Message-Id: <1030017237.5486.2.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v7AV/6fmBdEtC/oCap8V
Content-Type: multipart/mixed; boundary="=-IN+QQSeddbgGOCrFpuuS"


--=-IN+QQSeddbgGOCrFpuuS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mit, 2002-08-21 um 17.02 schrieb Alan Cox:

> Please send me an lspci -v, the drive info and the dmesg. I can at least
> add it to the reports to find patters even if nothing else

Attached.
=20
--=20
Servus,
       Daniel

--=-IN+QQSeddbgGOCrFpuuS
Content-Disposition: inline; filename=out
Content-Type: text/plain; name=out; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


/dev/hda:

 Model=3DIBM-DTLA-307015, FwRev=3DTX2OA50C, SerialNo=3DYF0YFT57413
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D40
 BuffType=3DDualPortCache, BuffSize=3D1916kB, MaxMultSect=3D16, MultSect=3D=
off
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D30003120
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4=20
 DMA modes:  mdma0 mdma1 mdma2=20
 UDMA modes: udma0 udma1 *udma2=20
 AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5

Linux version 2.4.18-k6 (herbert@gondolin) (gcc version 2.95.4 20011002 (De=
bian prerelease)) #1 Sun Apr 14 12:43:22 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D302 ide0=3Ddma ide1=
=3Ddma
Initializing CPU#0
Detected 801.443 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1599.07 BogoMIPS
Memory: 253560k/262080k available (799k kernel code, 8132k reserved, 220k d=
ata, 196k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor =3D 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb440, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SH=
ARE_IRQ SERIAL_PCI enabled
block: 128 slots per queue, batch=3D32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 2556 blocks [1 disk] into ram disk... |=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08done.
Freeing initrd memory: 2556k freed
VFS: Mounted root (cramfs filesystem).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DTLA-307015, ATA DISK drive
hdc: 24X10, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 30003120 sectors (15362 MB) w/1916KiB Cache, CHS=3D29765/16/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1867/255/63] p1 p2 p3 p4 < p5 p6=
 >
cramfs: wrong magic
reiserfs: checking transaction log (device 03:02) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
change_root: old root has d_count=3D2
Freeing unused kernel memory: 196k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 136512k swap-space (priority -1)
Real Time Clock Driver v1.10e
Via 686a audio driver 1.9.1
PCI: Found IRQ 5 for device 00:07.5
ac97_codec: AC97 Audio codec, id: 0x414c:0x4325 (Unknown)
via82cxxx: Codec rate locked at 48Khz
via82cxxx: board #1 at 0xDC00, IRQ 5
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: ATAPI     Model: CD-R/RW 24X10     Rev: P.MJ
  Type:   CD-ROM                             ANSI SCSI revision: 02
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 10 for device 00:09.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0a0f000, 00:e0:7d:94:e5:33, IRQ 1=
0
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
45e1.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev =
02)
	Subsystem: Elitegroup Computer Systems: Unknown device 0979
	Flags: bus master, medium devsel, latency 32
	Memory at d0000000 (32-bit, prefetchable) [size=3D32M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (p=
rog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d2000000-d4ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog=
-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000 [size=3D16]
	Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UH=
CI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d400 [size=3D32]
	Capabilities: [80] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (r=
ev 30)
	Subsystem: Elitegroup Computer Systems: Unknown device 0979
	Flags: medium devsel, IRQ 3
	Capabilities: [68] Power Management version 2

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 A=
udio Controller (rev 20)
	Subsystem: Avance Logic Inc.: Unknown device 10ec
	Flags: medium devsel, IRQ 5
	I/O ports at dc00 [size=3D256]
	I/O ports at e000 [size=3D4]
	I/O ports at e400 [size=3D4]
	Capabilities: [c0] Power Management version 2

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C=
 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e800 [size=3D256]
	Memory at d5000000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/=
2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Pro Turbo AGP 2X
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 10
	Memory at d2000000 (32-bit, non-prefetchable) [size=3D16M]
	I/O ports at c000 [size=3D256]
	Memory at d4000000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [50] AGP version 1.0


--=-IN+QQSeddbgGOCrFpuuS--

--=-v7AV/6fmBdEtC/oCap8V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ZNDUchlzsq9KoIYRAn20AKCsm/ywCde2WcdW6dcv4bSt47SLQgCfTty6
gjiWdBrcfW2oY7dGZ5k87ho=
=YzJk
-----END PGP SIGNATURE-----

--=-v7AV/6fmBdEtC/oCap8V--

