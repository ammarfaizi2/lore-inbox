Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262234AbSJNXyL>; Mon, 14 Oct 2002 19:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJNXyL>; Mon, 14 Oct 2002 19:54:11 -0400
Received: from 137-123-ADSL.red.retevision.es ([80.224.123.137]:47555 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S262234AbSJNXyC>; Mon, 14 Oct 2002 19:54:02 -0400
Date: Tue, 15 Oct 2002 02:07:18 +0200
From: Javier Marcet <jmarcet@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Gerd Knorr <kraxel@bytesex.org>, vdr@linuxtv.org, linux-dvb@linuxtv.org
Subject: Re: bttv and DVB cards hardware incompaibility only in late linux
Message-ID: <20021015000718.GA13951@jerry.marcet.dyndns.org>
References: <20021014235441.GA12048@jerry.marcet.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20021014235441.GA12048@jerry.marcet.dyndns.org>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the attachments on the previous e-mail, the go now :)


--=20
Javier Marcet <jmarcet@pobox.com>
Saint Louis University, Madrid Campus

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg output without the dvb card plugged
Content-Disposition: attachment; filename=dmesg-right

Linux version 2.4.20-pre8-ac3-marcet (root@jerry.marcet.dyndns.org) (gcc version 3.2) #1 Tue Oct 15 00:12:27 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 98284
zone(0): 4096 pages.
zone(1): 94188 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6a70
ACPI: RSDT (v001 ASUS   A7V-133  12336.12337) @ 0x17fec000
ACPI: FADT (v001 ASUS   A7V-133  12336.12337) @ 0x17fec080
ACPI: BOOT (v001 ASUS   A7V-133  12336.12337) @ 0x17fec040
ACPI: DSDT (v001   ASUS A7V-133  00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: root=/dev/sda2 video=matrox:mem:32,xres:1280,yres:960,left:264,right:24,hslen:160,upper:47,lower:1,vslen:3,pixclock:6024,sync:0x03,depth:32,pan panicblink=2
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1544.796 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3039.23 BogoMIPS
Memory: 383020k/393136k available (1663k kernel code, 7552k reserved, 326k data, 276k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=48149 max_file_pages=0 max_inodes=0 max_dentries=48149
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
HZ: Currently used HZ value is (1000)
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1544.0161 MHz.
..... host bus clock speed is 268.0549 MHz.
cpu: 0, clocks: 268549, slice: 134274
CPU0<T0:268544,T1:134256,D:14,S:134274,C:268549>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021002
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Scanning bus 00
Found 00:00 [1106/0305] 000600 00
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
Found 00:08 [1106/8305] 000604 01
Found 00:20 [1106/0686] 000601 00
Found 00:21 [1106/0571] 000101 00
Found 00:22 [1106/3038] 000c03 00
Found 00:23 [1106/3038] 000c03 00
Found 00:24 [1106/3057] 000680 00
Found 00:48 [1102/0002] 000401 00
Found 00:49 [1102/7002] 000980 00
Found 00:50 [109e/036e] 000400 00
Found 00:51 [109e/0878] 000480 00
Found 00:58 [9005/0010] 000100 00
Found 00:68 [10b7/9200] 000200 00
Found 00:88 [105a/0d30] 000180 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [102b/0525] 000300 00
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Bus scan for 00 returning with max=01
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc4f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc520, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PnPBIOS: PNP0c02: ioport range 0xe400-0xe47f has been reserved
PnPBIOS: PNP0c02: ioport range 0xe800-0xe83f could not be reserved
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1280x960x32bpp (virtual: 1280x3276)
matroxfb: framebuffer at 0xE2000000, mapped to 0xd880f000, size 33554432
Console: switching to colour frame buffer device 160x60
fb0: MATROX VGA frame buffer device
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
PDC20265: IDE controller at PCI slot 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:DMA, hdh:DMA
hda: IBM-DTLA-307045, ATA DISK drive
hda: DMA disabled
blk: queue c0368940, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

spurious 8259A interrupt: IRQ7.
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: TEAC      Model: CD-R56S           Rev: 1.0P
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
reiserfs: checking transaction log (device 08:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 276k freed
Adding Swap: 530104k swap-space (priority -1)
reiserfs: checking transaction log (device 08:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:0a) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Real Time Clock Driver v1.10e
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0d.0: 3Com PCI 3c905C Tornado at 0x9400. Vers LK1.1.18-ac
usb-uhci.c: $Revision: 1.275 $ time 00:19:22 Oct 15 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:04.2-1, assigned address 2
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: new USB device 00:04.2-1.4, assigned address 3
usb.c: USB device 3 (vend/prod 0x9ef/0x101) is not claimed by any active driver.
hub.c: new USB device 00:04.2-1.5, assigned address 4
usb.c: USB device 4 (vend/prod 0x43e/0x42bd) is not claimed by any active driver.

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Description: dmesg output _with_ the dvb card installed
Content-Disposition: attachment; filename=dmesg-wrong

Linux version 2.4.20-pre8-ac3-marcet (root@jerry.marcet.dyndns.org) (gcc version 3.2) #1 Tue Oct 15 00:12:27 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 98284
zone(0): 4096 pages.
zone(1): 94188 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f6a70
ACPI: RSDT (v001 ASUS   A7V-133  12336.12337) @ 0x17fec000
ACPI: FADT (v001 ASUS   A7V-133  12336.12337) @ 0x17fec080
ACPI: BOOT (v001 ASUS   A7V-133  12336.12337) @ 0x17fec040
ACPI: DSDT (v001   ASUS A7V-133  00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: root=/dev/sda2 video=matrox:mem:32,xres:1280,yres:960,left:264,right:24,hslen:160,upper:47,lower:1,vslen:3,pixclock:6024,sync:0x03,depth:32,pan panicblink=2
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1544.751 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3039.23 BogoMIPS
Memory: 383020k/393136k available (1663k kernel code, 7552k reserved, 326k data, 276k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=48149 max_file_pages=0 max_inodes=0 max_dentries=48149
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
HZ: Currently used HZ value is (1000)
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1544.0164 MHz.
..... host bus clock speed is 268.0550 MHz.
cpu: 0, clocks: 268550, slice: 134275
CPU0<T0:268544,T1:134256,D:13,S:134275,C:268550>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021002
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Scanning bus 00
Found 00:00 [1106/0305] 000600 00
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
Found 00:08 [1106/8305] 000604 01
Found 00:20 [1106/0686] 000601 00
Found 00:21 [1106/0571] 000101 00
Found 00:22 [1106/3038] 000c03 00
Found 00:23 [1106/3038] 000c03 00
Found 00:24 [1106/3057] 000680 00
Found 00:50 [1131/7146] 000480 00
Found 00:58 [9005/0010] 000100 00
Found 00:60 [109e/036e] 000400 00
Found 00:61 [109e/0878] 000480 00
Found 00:68 [10b7/9200] 000200 00
Found 00:88 [105a/0d30] 000180 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [102b/0525] 000300 00
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Bus scan for 00 returning with max=01
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc4f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc520, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PnPBIOS: PNP0c02: ioport range 0xe400-0xe47f has been reserved
PnPBIOS: PNP0c02: ioport range 0xe800-0xe83f could not be reserved
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1280x960x32bpp (virtual: 1280x3276)
matroxfb: framebuffer at 0xE2000000, mapped to 0xd880f000, size 33554432
Console: switching to colour frame buffer device 160x60
fb0: MATROX VGA frame buffer device
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
PDC20265: IDE controller at PCI slot 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:DMA, hdh:pio
hda: IBM-DTLA-307045, ATA DISK drive
hda: DMA disabled
blk: queue c0368940, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

spurious 8259A interrupt: IRQ7.
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: TEAC      Model: CD-R56S           Rev: 1.0P
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
reiserfs: checking transaction log (device 08:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 276k freed
Adding Swap: 530104k swap-space (priority -1)
reiserfs: checking transaction log (device 08:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:0a) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Real Time Clock Driver v1.10e
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0d.0: 3Com PCI 3c905C Tornado at 0xa000. Vers LK1.1.18-ac
usb-uhci.c: $Revision: 1.275 $ time 00:19:22 Oct 15 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:04.2-1, assigned address 2
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: new USB device 00:04.2-1.4, assigned address 3
usb.c: USB device 3 (vend/prod 0x9ef/0x101) is not claimed by any active driver.
hub.c: new USB device 00:04.2-1.5, assigned address 4
usb.c: USB device 4 (vend/prod 0x43e/0x42bd) is not claimed by any active driver.

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Description: syslog of bttv's good behavior
Content-Disposition: attachment; filename=log-right

Oct 15 01:07:24 [kernel] Linux video capture interface: v1.00
Oct 15 01:07:24 [kernel] i2c-core.o: i2c core module version 2.6.5 (20020915)
Oct 15 01:07:25 [kernel] bttv0: Hauppauge eeprom: model=44354, tuner=Temic 4009FR5 (20), radio=yes
Oct 15 01:07:25 [kernel] msp34xx: init: chip=MSP3415D-B3, has NICAM support
Oct 15 01:07:25 [kernel] msp3410: daemon started
Oct 15 01:07:25 [kernel] bttv0: i2c attach [client=MSP3415D-B3,ok]
Oct 15 01:07:25 [kernel] tvaudio: TV audio decoder + audio/video mux driver
Oct 15 01:07:25 [kernel] tuner: probing bt848 #0 i2c adapter [id=0x10005]
Oct 15 01:07:25 [kernel] tuner: chip found @ 0xc2
Oct 15 01:07:25 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 01:07:25 [kernel] msp3410: detection still in progress
Oct 15 01:07:25 [kernel] msp3410: detection still in progress
Oct 15 01:07:25 [kernel] msp3410: current mode: ERROR (0x0000)
Oct 15 01:07:25 [kernel] msp34xx: setbass: 32768 0x00
Oct 15 01:07:39 [kernel] bttv0: open called
Oct 15 01:07:39 [kernel] Display at e2000000 is 1280 by 3276, bytedepth 4, bpl 5120
Oct 15 01:07:40 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 01:07:40 [kernel] msp3410: detection still in progress
Oct 15 01:07:40 [kernel] msp3410: current mode: 5.5/5.85  B/G NICAM FM (0x0008)
Oct 15 01:07:41 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 01:07:41 [kernel] msp3410: detection still in progress
Oct 15 01:07:41 [kernel] msp3410: detection still in progress
Oct 15 01:07:41 [kernel] msp3410: current mode: 5.5/5.74  B/G Dual FM-Stereo (0x0003)
Oct 15 01:07:42 [kernel] msp34xx: stereo detect register: 0
Oct 15 01:07:47 [kernel] bttv0: clip: ro=12828000 re=12820000
Oct 15 01:07:56 [kernel] bttv0: clip: ro=12828000 re=12820000
Oct 15 01:08:09 [kernel] bttv0: clip: ro=12828000 re=12820000
Oct 15 01:08:44 [kernel] bttv0: unloading
Oct 15 01:08:44 [kernel] msp3410: thread: exit
Oct 15 01:08:57 [fcron] SIGTERM signal received
Oct 15 01:08:57 [fcron] Exiting with code 0


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Description: syslog of bttv's errors when the dvb board is also installed
Content-Disposition: attachment; filename=log-wrong

Oct 15 00:51:22 [kernel] Linux video capture interface: v1.00
Oct 15 00:51:22 [kernel] i2c-core.o: i2c core module version 2.6.5 (20020915)
Oct 15 00:51:22 [kernel] bttv0: Hauppauge eeprom: model=44354, tuner=Temic 4009FR5 (20), radio=yes
Oct 15 00:51:22 [kernel] msp34xx: init: chip=MSP3415D-B3, has NICAM support
Oct 15 00:51:22 [kernel] msp3410: daemon started
Oct 15 00:51:22 [kernel] bttv0: i2c attach [client=MSP3415D-B3,ok]
Oct 15 00:51:22 [kernel] tvaudio: TV audio decoder + audio/video mux driver
Oct 15 00:51:22 [kernel] tuner: probing bt848 #0 i2c adapter [id=0x10005]
Oct 15 00:51:22 [kernel] tuner: chip found @ 0xc2
Oct 15 00:51:22 [kernel] bttv0: registered device video0
Oct 15 00:51:33 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x9
Oct 15 00:51:33 [kernel] bttv0: irq: SCERR risc_count=12670014
Oct 15 00:51:33 [kernel] bttv0: irq: SCERR risc_count=12670014
Oct 15 00:51:38 [kernel] bttv0: resetting chip
Oct 15 00:51:38 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=12670014
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=12670014
Oct 15 00:51:38 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x9
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=12670000


Oct 15 00:54:45 [kernel] Linux video capture interface: v1.00
Oct 15 00:54:45 [kernel] i2c-core.o: i2c core module version 2.6.5 (20020915)
Oct 15 00:54:45 [kernel] msp34xx: init: chip=MSP3415D-B3, has NICAM support
Oct 15 00:54:45 [kernel] msp3410: daemon started
Oct 15 00:54:45 [kernel] bttv0: i2c attach [client=MSP3415D-B3,ok]
Oct 15 00:54:45 [kernel] tvaudio: TV audio decoder + audio/video mux driver
Oct 15 00:54:45 [kernel] tuner: probing bt848 #0 i2c adapter [id=0x10005]
Oct 15 00:54:45 [kernel] tuner: chip found @ 0xc2
Oct 15 00:54:45 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 00:54:45 [kernel] msp3410: detection still in progress
Oct 15 00:54:45 [kernel] msp3410: current mode: 5.5/5.85  B/G NICAM FM (0x0008)
Oct 15 00:54:45 [kernel] msp3400: NICAM setstereo: stereo
Oct 15 00:54:46 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:54 [kernel] bttv0: open called
Oct 15 00:54:54 [kernel] Display at e2000000 is 1280 by 3276, bytedepth 4, bpl 5120
Oct 15 00:54:54 [kernel] bttv0: open called
Oct 15 00:54:54 [kernel] bttv0: open called
Oct 15 00:54:54 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:54 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:54 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:54 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:54:55 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 00:54:55 [kernel] msp3410: detection still in progress
Oct 15 00:54:55 [kernel] msp3410: current mode: 5.5/5.85  B/G NICAM FM (0x0008)
Oct 15 00:54:56 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:59 [kernel] bttv0: resetting chip
Oct 15 00:55:00 [kernel] ok
Oct 15 00:55:00 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:55:00 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:55:00 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:55:01 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x9
Oct 15 00:55:01 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 00:55:01 [kernel] msp3410: detection still in progress
Oct 15 00:55:01 [kernel] msp3410: detection still in progress
Oct 15 00:55:01 [kernel] msp3410: current mode: 5.5/5.74  B/G Dual FM-Stereo (0x0003)
Oct 15 00:55:02 [kernel] msp34xx: stereo detect register: 0
Oct 15 00:55:05 [kernel] bttv0: unloading
Oct 15 00:55:05 [kernel] msp3410: thread: exit

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Description: lspci-> bttv +/- correctly identified by the kernel
Content-Disposition: attachment; filename=lspci-right

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
	Flags: bus master, medium devsel, latency 8
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: df000000-e06fffff
	Prefetchable memory behind bridge: e1f00000-e3ffffff
	Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
	Subsystem: Creative Labs CT4620 SBLive!
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at a400 [size=32]
	Capabilities: [dc] Power Management version 1

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 01)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at a000 [size=8]
	Capabilities: [dc] Power Management version 1

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Flags: bus master, medium devsel, latency 32, IRQ 15
	Memory at e1000000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Flags: bus master, medium devsel, latency 32, IRQ 15
	Memory at e0800000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:0b.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
	Subsystem: Adaptec AHA-2940U2W SCSI Controller
	Flags: bus master, medium devsel, latency 32, IRQ 10
	BIST result: 00
	I/O ports at 9800 [disabled] [size=256]
	Memory at de800000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at 9400 [size=128]
	Memory at de000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 9000 [size=8]
	I/O ports at 8800 [size=4]
	I/O ports at 8400 [size=8]
	I/O ports at 8000 [size=4]
	I/O ports at 7800 [size=64]
	Memory at dd800000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at e2000000 (32-bit, prefetchable) [size=32M]
	Memory at df800000 (32-bit, non-prefetchable) [size=16K]
	Memory at df000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at e1ff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [f0] AGP version 2.0


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Description: lspci-> bttv as unknown card when dvb board is in
Content-Disposition: attachment; filename=log-wrong

Oct 15 00:51:22 [kernel] Linux video capture interface: v1.00
Oct 15 00:51:22 [kernel] i2c-core.o: i2c core module version 2.6.5 (20020915)
Oct 15 00:51:22 [kernel] bttv0: Hauppauge eeprom: model=44354, tuner=Temic 4009FR5 (20), radio=yes
Oct 15 00:51:22 [kernel] msp34xx: init: chip=MSP3415D-B3, has NICAM support
Oct 15 00:51:22 [kernel] msp3410: daemon started
Oct 15 00:51:22 [kernel] bttv0: i2c attach [client=MSP3415D-B3,ok]
Oct 15 00:51:22 [kernel] tvaudio: TV audio decoder + audio/video mux driver
Oct 15 00:51:22 [kernel] tuner: probing bt848 #0 i2c adapter [id=0x10005]
Oct 15 00:51:22 [kernel] tuner: chip found @ 0xc2
Oct 15 00:51:22 [kernel] bttv0: registered device video0
Oct 15 00:51:33 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x9
Oct 15 00:51:33 [kernel] bttv0: irq: SCERR risc_count=12670014
Oct 15 00:51:33 [kernel] bttv0: irq: SCERR risc_count=12670014
Oct 15 00:51:38 [kernel] bttv0: resetting chip
Oct 15 00:51:38 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=12670014
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=12670014
Oct 15 00:51:38 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x9
Oct 15 00:51:38 [kernel] bttv0: irq: SCERR risc_count=12670000


Oct 15 00:54:45 [kernel] Linux video capture interface: v1.00
Oct 15 00:54:45 [kernel] i2c-core.o: i2c core module version 2.6.5 (20020915)
Oct 15 00:54:45 [kernel] msp34xx: init: chip=MSP3415D-B3, has NICAM support
Oct 15 00:54:45 [kernel] msp3410: daemon started
Oct 15 00:54:45 [kernel] bttv0: i2c attach [client=MSP3415D-B3,ok]
Oct 15 00:54:45 [kernel] tvaudio: TV audio decoder + audio/video mux driver
Oct 15 00:54:45 [kernel] tuner: probing bt848 #0 i2c adapter [id=0x10005]
Oct 15 00:54:45 [kernel] tuner: chip found @ 0xc2
Oct 15 00:54:45 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 00:54:45 [kernel] msp3410: detection still in progress
Oct 15 00:54:45 [kernel] msp3410: current mode: 5.5/5.85  B/G NICAM FM (0x0008)
Oct 15 00:54:45 [kernel] msp3400: NICAM setstereo: stereo
Oct 15 00:54:46 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:54 [kernel] bttv0: open called
Oct 15 00:54:54 [kernel] Display at e2000000 is 1280 by 3276, bytedepth 4, bpl 5120
Oct 15 00:54:54 [kernel] bttv0: open called
Oct 15 00:54:54 [kernel] bttv0: open called
Oct 15 00:54:54 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:54 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:54 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:54 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:54:55 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 00:54:55 [kernel] msp3410: detection still in progress
Oct 15 00:54:55 [kernel] msp3410: current mode: 5.5/5.85  B/G NICAM FM (0x0008)
Oct 15 00:54:56 [kernel] msp34xx: nicam sync=1, mode=8
Oct 15 00:54:59 [kernel] bttv0: resetting chip
Oct 15 00:55:00 [kernel] ok
Oct 15 00:55:00 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:55:00 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:55:00 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x8
Oct 15 00:55:01 [kernel] scsi0: PCI error Interrupt at seqaddr = 0x9
Oct 15 00:55:01 [kernel] msp3410: setting mode: autodetect start (0x0001)
Oct 15 00:55:01 [kernel] msp3410: detection still in progress
Oct 15 00:55:01 [kernel] msp3410: detection still in progress
Oct 15 00:55:01 [kernel] msp3410: current mode: 5.5/5.74  B/G Dual FM-Stereo (0x0003)
Oct 15 00:55:02 [kernel] msp34xx: stereo detect register: 0
Oct 15 00:55:05 [kernel] bttv0: unloading
Oct 15 00:55:05 [kernel] msp3410: thread: exit

--OXfL5xGRrasGEqWY--

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iEYEARECAAYFAj2rXDYACgkQx/ptJkB7fryKUQCZAWrYVFpZkLQRP08hsGYoxYRh
8uwAnjE0fRKJ2wrb7eX5uUvBpzp4lX/2
=3kN3
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
