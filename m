Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUGEToE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUGEToE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUGEToE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:44:04 -0400
Received: from adsl-65-68-136-66.dsl.stlsmo.swbell.net ([65.68.136.66]:35200
	"EHLO demigod.technicalworks.net") by vger.kernel.org with ESMTP
	id S261300AbUGETnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:43:43 -0400
Message-ID: <004101c462c8$b870fbd0$0200000a@darkomen.lan>
From: "Dwayne Rightler" <drightler@technicalogic.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.7 "Unable to handle kernel paging request" plus kobject_get badness
Date: Mon, 5 Jul 2004 14:46:08 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003E_01C4629E.CEA4FB10"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Spam-DCC: :
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_003E_01C4629E.CEA4FB10
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello,

I've never reported a kernel error before so please let me know if there is
more info I can provide.  Running 2.6.7 with the kexec patch.  Was not
having these problems with 2.6.5 with the kexec patch.  After the "Unable to
handle kernel paging request" error the machine becomes fairly unresponsive
and a normal reboot is not enough to bring the machine down.  Dmesg and
config attached.

-Dwayne Rightler

------=_NextPart_000_003E_01C4629E.CEA4FB10
Content-Type: application/octet-stream;
	name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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

------=_NextPart_000_003E_01C4629E.CEA4FB10
Content-Type: application/octet-stream;
	name="2.5.7-kexec.dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2.5.7-kexec.dmesg"

Linux version 2.6.7-kexec (root@demigod) (gcc version 2.95.4 20011002 =
(Debian prerelease)) #1 Mon Jul 5 11:30:36 CDT 2004=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0A=
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000ec000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 0000000027ff0000 (usable)=0A=
 BIOS-e820: 0000000027ff0000 - 0000000027ff8000 (ACPI data)=0A=
 BIOS-e820: 0000000027ff8000 - 0000000028000000 (ACPI NVS)=0A=
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)=0A=
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)=0A=
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)=0A=
639MB LOWMEM available.=0A=
found SMP MP-table at 000fb210=0A=
On node 0 totalpages: 163824=0A=
  DMA zone: 4096 pages, LIFO batch:1=0A=
  Normal zone: 159728 pages, LIFO batch:16=0A=
  HighMem zone: 0 pages, LIFO batch:1=0A=
DMI 2.3 present.=0A=
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa970=0A=
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x27ff0000=0A=
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x27ff0030=0A=
ACPI: MADT (v001 AMIINT          0x00000009 MSFT 0x00000097) @ 0x27ff00b0=0A=
ACPI: DSDT (v001    VIA   VT8371 0x00001000 MSFT 0x0100000b) @ 0x00000000=0A=
ACPI: Local APIC address 0xfee00000=0A=
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)=0A=
Processor #0 6:3 APIC version 16=0A=
Using ACPI for processor (LAPIC) configuration information=0A=
Intel MultiProcessor Specification v1.1=0A=
    Virtual Wire compatibility mode.=0A=
OEM ID: VIA      Product ID: KT133        APIC at: 0xFEE00000=0A=
I/O APIC #2 Version 17 at 0xFEC00000.=0A=
Enabling APIC mode:  Flat.  Using 1 I/O APICs=0A=
Processors: 1=0A=
Built 1 zonelists=0A=
Kernel command line: root=3D/dev/hdb1=0A=
Initializing CPU#0=0A=
PID hash table entries: 4096 (order 12: 32768 bytes)=0A=
Detected 850.483 MHz processor.=0A=
Using tsc for high-res timesource=0A=
Console: colour VGA+ 80x25=0A=
Memory: 645260k/655296k available (2455k kernel code, 9284k reserved, =
1141k data, 152k init, 0k highmem)=0A=
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.=0A=
Calibrating delay loop... 1671.16 BogoMIPS=0A=
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)=0A=
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)=0A=
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 =
00000000=0A=
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000=0A=
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)=0A=
CPU: L2 Cache: 64K (64 bytes/line)=0A=
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020=0A=
CPU: AMD Duron(tm) stepping 01=0A=
Enabling fast FPU save and restore... done.=0A=
Checking 'hlt' instruction... OK.=0A=
enabled ExtINT on CPU#0=0A=
ESR value before enabling vector: 00000080=0A=
ESR value after enabling vector: 00000000=0A=
ENABLING IO-APIC IRQs=0A=
Setting 2 in the phys_id_present_map=0A=
...changing IO-APIC physical APIC ID to 2 ... ok.=0A=
init IO_APIC IRQs=0A=
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, =
2-23 not connected.=0A=
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0=0A=
number of MP IRQ sources: 16.=0A=
number of IO-APIC #2 registers: 24.=0A=
testing the IO APIC.......................=0A=
IO APIC #2......=0A=
.... register #00: 02000000=0A=
.......    : physical APIC id: 02=0A=
.......    : Delivery Type: 0=0A=
.......    : LTS          : 0=0A=
.... register #01: 00178011=0A=
.......     : max redirection entries: 0017=0A=
.......     : PRQ implemented: 1=0A=
.......     : IO APIC version: 0011=0A=
.... register #02: 00000000=0A=
.......     : arbitration: 00=0A=
.... IRQ redirection table:=0A=
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   =0A=
 00 000 00  1    0    0   0   0    0    0    00=0A=
 01 001 01  0    0    0   0   0    1    1    39=0A=
 02 001 01  0    0    0   0   0    1    1    31=0A=
 03 001 01  0    0    0   0   0    1    1    41=0A=
 04 001 01  0    0    0   0   0    1    1    49=0A=
 05 001 01  1    1    0   1   0    1    1    51=0A=
 06 001 01  0    0    0   0   0    1    1    59=0A=
 07 001 01  0    0    0   0   0    1    1    61=0A=
 08 001 01  0    0    0   0   0    1    1    69=0A=
 09 001 01  1    1    0   1   0    1    1    71=0A=
 0a 001 01  1    1    0   1   0    1    1    79=0A=
 0b 001 01  1    1    0   1   0    1    1    81=0A=
 0c 001 01  0    0    0   0   0    1    1    89=0A=
 0d 001 01  0    0    0   0   0    1    1    91=0A=
 0e 001 01  0    0    0   0   0    1    1    99=0A=
 0f 001 01  0    0    0   0   0    1    1    A1=0A=
 10 000 00  1    0    0   0   0    0    0    00=0A=
 11 000 00  1    0    0   0   0    0    0    00=0A=
 12 000 00  1    0    0   0   0    0    0    00=0A=
 13 000 00  1    0    0   0   0    0    0    00=0A=
 14 000 00  1    0    0   0   0    0    0    00=0A=
 15 000 00  1    0    0   0   0    0    0    00=0A=
 16 000 00  1    0    0   0   0    0    0    00=0A=
 17 050 00  1    0    0   0   0    0    2    00=0A=
IRQ to pin mappings:=0A=
IRQ0 -> 0:2=0A=
IRQ1 -> 0:1=0A=
IRQ3 -> 0:3=0A=
IRQ4 -> 0:4=0A=
IRQ5 -> 0:5=0A=
IRQ6 -> 0:6=0A=
IRQ7 -> 0:7=0A=
IRQ8 -> 0:8=0A=
IRQ9 -> 0:9=0A=
IRQ10 -> 0:10=0A=
IRQ11 -> 0:11=0A=
IRQ12 -> 0:12=0A=
IRQ13 -> 0:13=0A=
IRQ14 -> 0:14=0A=
IRQ15 -> 0:15=0A=
.................................... done.=0A=
Using local APIC timer interrupts.=0A=
calibrating APIC timer ...=0A=
..... CPU clock speed is 849.0887 MHz.=0A=
..... host bus clock speed is 199.0973 MHz.=0A=
NET: Registered protocol family 16=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=3D1=0A=
PCI: Using configuration type 1=0A=
mtrr: v2.0 (20020519)=0A=
Linux Plug and Play Support v0.97 (c) Adam Belay=0A=
PnPBIOS: Scanning system for PnP BIOS support...=0A=
PnPBIOS: Found PnP BIOS installation structure at 0xc00f71d0=0A=
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5f74, dseg 0xf0000=0A=
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver=0A=
PCI: Probing PCI hardware=0A=
PCI: Probing PCI hardware (bus 00)=0A=
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0=0A=
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).=0A=
Initializing Cryptographic API=0A=
Applying VIA southbridge workaround.=0A=
PCI: Enabling Via external APIC routing=0A=
isapnp: Scanning for PnP cards...=0A=
isapnp: No Plug & Play device found=0A=
lp: driver loaded but no devices found=0A=
Real Time Clock Driver v1.12=0A=
Non-volatile memory driver v1.2=0A=
Linux agpgart interface v0.100 (c) Dave Jones=0A=
agpgart: Detected VIA KLE133 chipset=0A=
agpgart: Maximum main memory to use for agp memory: 564M=0A=
agpgart: AGP aperture is 64M @ 0xe0000000=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled=0A=
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A=
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0A=
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]=0A=
lp0: using parport0 (polling).=0A=
parport_pc: Via 686A parallel port: io=3D0x378=0A=
Using anticipatory io scheduler=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a post-1991 82077=0A=
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
loop: loaded (max 8 devices)=0A=
nbd: registered device at major 43=0A=
via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker=0A=
eth0: VIA VT86C100A Rhine at 0xdffffe80, 00:50:ba:c4:1f:93, IRQ 9.=0A=
eth0: MII PHY found at address 8, status 0x782d advertising 05e1 Link =
40a1.=0A=
PPP generic driver version 2.4.2=0A=
PPP Deflate Compression module registered=0A=
PPP BSD Compression module registered=0A=
NET: Registered protocol family 24=0A=
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky=0A=
Loaded prism54 driver, version 1.1=0A=
eth1: prism54 driver detected card model: XG-900/GW-DS54G=0A=
Linux Tulip driver version 1.1.13 (May 11, 2002)=0A=
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.=0A=
eth2: Lite-On 82c168 PNIC rev 32 at 0xe8828f00, 00:A0:CC:29:35:97, IRQ 5.=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: IDE controller at PCI slot 0000:00:07.1=0A=
VP_IDE: chipset revision 6=0A=
VP_IDE: not 100% native mode: will probe irqs later=0A=
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1=0A=
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA=0A=
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio=0A=
hda: SAMSUNG SV2044D, ATA DISK drive=0A=
hdb: Maxtor 90845D4, ATA DISK drive=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
hdc: Hewlett-Packard CD-Writer Plus 9300, ATAPI CD/DVD-ROM drive=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
PDC20267: IDE controller at PCI slot 0000:00:0f.0=0A=
PDC20267: chipset revision 2=0A=
PDC20267: ROM enabled at 0xdff60000=0A=
PDC20267: 100% native mode on irq 10=0A=
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.=0A=
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:pio, hdf:pio=0A=
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:pio, hdh:pio=0A=
hde: Maxtor 53073H4, ATA DISK drive=0A=
hdf: Maxtor 92720U8, ATA DISK drive=0A=
ide2 at 0xdc00-0xdc07,0xd802 on irq 10=0A=
hda: max request size: 128KiB=0A=
hda: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=3D39546/16/63=0A=
 hda: hda1 hda2 hda3=0A=
hdb: max request size: 128KiB=0A=
hdb: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=3D16383/16/63=0A=
 hdb: hdb1=0A=
hde: max request size: 128KiB=0A=
hde: 60030432 sectors (30735 MB) w/2048KiB Cache, CHS=3D59554/16/63=0A=
 hde: unknown partition table=0A=
hdf: max request size: 128KiB=0A=
hdf: 53177040 sectors (27226 MB) w/2048KiB Cache, CHS=3D52755/16/63=0A=
 hdf: hdf1=0A=
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache=0A=
Uniform CD-ROM driver Revision: 3.20=0A=
mice: PS/2 mouse device common for all mice=0A=
input: PC Speaker=0A=
serio: i8042 AUX port at 0x60,0x64 irq 12=0A=
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1=0A=
serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
input: AT Translated Set 2 keyboard on isa0060/serio0=0A=
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com=0A=
NET: Registered protocol family 2=0A=
IP: routing cache hash table of 8192 buckets, 64Kbytes=0A=
TCP: Hash tables configured (established 262144 bind 65536)=0A=
ip_conntrack version 2.1 (5119 buckets, 40952 max) - 300 bytes per =
conntrack=0A=
ip_tables: (C) 2000-2002 Netfilter core team=0A=
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  =
http://snowman.net/projects/ipt_recent/=0A=
arp_tables: (C) 2002 David S. Miller=0A=
NET: Registered protocol family 1=0A=
NET: Registered protocol family 17=0A=
Bridge firewalling registered=0A=
Ebtables v2.0 registered=0A=
EXT3-fs: INFO: recovery required on readonly filesystem.=0A=
EXT3-fs: write access will be enabled during recovery.=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: hdb1: orphan cleanup on readonly fs=0A=
ext3_orphan_cleanup: deleting unreferenced inode 98307=0A=
ext3_orphan_cleanup: deleting unreferenced inode 98306=0A=
EXT3-fs: hdb1: 2 orphan inodes deleted=0A=
EXT3-fs: recovery complete.=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
VFS: Mounted root (ext3 filesystem) readonly.=0A=
Freeing unused kernel memory: 152k freed=0A=
Adding 626524k swap on /dev/hda2.  Priority:-1 extents:1=0A=
EXT3 FS on hdb1, internal journal=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3 FS on hda1, internal journal=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3 FS on dm-0, internal journal=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
device eth2 entered promiscuous mode=0A=
device tap0 entered promiscuous mode=0A=
eth2: Promiscuous mode enabled.=0A=
eth2: Promiscuous mode enabled.=0A=
eth2: Promiscuous mode enabled.=0A=
eth2: Promiscuous mode enabled.=0A=
eth2: Promiscuous mode enabled.=0A=
br0: port 2(tap0) entering learning state=0A=
br0: port 1(eth2) entering learning state=0A=
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT=0A=
eth2: Setting full-duplex based on MII#1 link partner capability of 05e1.=0A=
process `named' is using obsolete setsockopt SO_BSDCOMPAT=0A=
br0: topology change detected, propgating=0A=
br0: port 2(tap0) entering forwarding state=0A=
br0: topology change detected, propgating=0A=
br0: port 1(eth2) entering forwarding state=0A=
br0: port 2(tap0) entering disabled state=0A=
br0: port 1(eth2) entering disabled state=0A=
eth2: Promiscuous mode enabled.=0A=
br0: port 2(tap0) entering disabled state=0A=
br0: port 1(eth2) entering disabled state=0A=
eth1: islpci_open()=0A=
eth1: resetting device...=0A=
eth1: uploading firmware...=0A=
eth1: firmware uploaded done, now triggering reset...=0A=
eth1 (WE) : Buffer for request SIOCGIWPRIV too small (16<100)=0A=
eth1 (WE) : Buffer for request SIOCGIWPRIV too small (32<100)=0A=
eth1 (WE) : Buffer for request SIOCGIWPRIV too small (64<100)=0A=
eth1 (WE) : Buffer for request SIOCGIWPRIV too small (16<100)=0A=
eth1 (WE) : Buffer for request SIOCGIWPRIV too small (32<100)=0A=
eth1 (WE) : Buffer for request SIOCGIWPRIV too small (64<100)=0A=
Badness in kobject_get at lib/kobject.c:433=0A=
 [<c024ee2e>] kobject_get+0x2e/0x40=0A=
 [<c024eb05>] kobject_init+0x25/0x40=0A=
 [<c024ec80>] kobject_register+0x10/0x50=0A=
 [<c0349d86>] br_sysfs_addbr+0xa6/0x100=0A=
 [<c03462a3>] br_add_bridge+0x73/0xb0=0A=
 [<c0347317>] old_deviceless+0x127/0x150=0A=
 [<c0347367>] br_ioctl_deviceless_stub+0x27/0xc0=0A=
 [<c02ea6a2>] sock_ioctl+0x1b2/0x2b0=0A=
 [<c0152e29>] sys_ioctl+0x1e9/0x240=0A=
 [<c01060f9>] error_code+0x2d/0x38=0A=
 [<c01056ef>] syscall_call+0x7/0xb=0A=
=0A=
eth2: Promiscuous mode enabled.=0A=
eth2: Promiscuous mode enabled.=0A=
eth2: Promiscuous mode enabled.=0A=
eth2: Promiscuous mode enabled.=0A=
eth2: Promiscuous mode enabled.=0A=
br0: port 2(tap0) entering learning state=0A=
br0: port 1(eth2) entering learning state=0A=
eth2: Setting full-duplex based on MII#1 link partner capability of 05e1.=0A=
br0: topology change detected, propgating=0A=
br0: port 2(tap0) entering forwarding state=0A=
br0: topology change detected, propgating=0A=
br0: port 1(eth2) entering forwarding state=0A=
hda: DMA disabled=0A=
hdb: dma_timer_expiry: dma status =3D=3D 0x41=0A=
hdb: DMA timeout error=0A=
hdb: dma timeout error: status=3D0xd0 { Busy }=0A=
=0A=
hdb: DMA disabled=0A=
ide0: reset: success=0A=
hdc: CHECK for good STATUS=0A=
Unable to handle kernel paging request at virtual address 00001004=0A=
 printing eip:=0A=
c01b5379=0A=
*pde =3D 00000000=0A=
Oops: 0000 [#1]=0A=
PREEMPT =0A=
CPU:    0=0A=
EIP:    0060:[<c01b5379>]    Not tainted=0A=
EFLAGS: 00010202   (2.6.7-kexec) =0A=
EIP is at __journal_remove_journal_head+0x9/0x130=0A=
eax: d0819a3c   ebx: 00001000   ecx: e7dada00   edx: d759bc8c=0A=
esi: d0819a3c   edi: d759bcbc   ebp: e0adc358   esp: e6b79df4=0A=
ds: 007b   es: 007b   ss: 0068=0A=
Process kjournald (pid: 524, threadinfo=3De6b78000 task=3De67b52a0)=0A=
Stack: e6b78000 d0819a3c c01b54b5 d0819a3c e6b78000 c01b0e69 d0819a3c =
e6b78000 =0A=
       00000001 e7dada6c e7dada00 e7dada78 e0adc3b0 e7dada54 e7dada3c =
c02c5c0c =0A=
       e6b79e68 00000000 00000000 00000000 00000000 00000000 d91c1b6c =
00000c1b =0A=
Call Trace:=0A=
 [<c01b54b5>] journal_remove_journal_head+0x15/0x30=0A=
 [<c01b0e69>] journal_commit_transaction+0x409/0xee0=0A=
 [<c02c5c0c>] __ide_set_handler+0x4c/0x60=0A=
 [<c0114930>] autoremove_wake_function+0x0/0x40=0A=
 [<c0114930>] autoremove_wake_function+0x0/0x40=0A=
 [<c0113090>] try_to_wake_up+0x20/0xb0=0A=
 [<c0113061>] deactivate_task+0x21/0x30=0A=
 [<c0364388>] schedule+0x3d8/0x430=0A=
 [<c01b3756>] kjournald+0xc6/0x250=0A=
 [<c01b3690>] kjournald+0x0/0x250=0A=
 [<c0114930>] autoremove_wake_function+0x0/0x40=0A=
 [<c0114930>] autoremove_wake_function+0x0/0x40=0A=
 [<c01b3670>] commit_timeout+0x0/0x10=0A=
 [<c0103ca5>] kernel_thread_helper+0x5/0x10=0A=
=0A=
Code: 83 7b 04 00 7d 29 68 c0 bd 38 c0 68 c0 06 00 00 68 ec b5 38 =0A=
 <6>note: kjournald[524] exited with preempt_count 2=0A=

------=_NextPart_000_003E_01C4629E.CEA4FB10--

