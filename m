Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRJ1NVM>; Sun, 28 Oct 2001 08:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278354AbRJ1NVE>; Sun, 28 Oct 2001 08:21:04 -0500
Received: from smtp-rt-9.wanadoo.fr ([193.252.19.55]:40399 "EHLO
	alisier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278364AbRJ1NUy>; Sun, 28 Oct 2001 08:20:54 -0500
Message-ID: <3BDC062F.6E15C2A2@e-nef.com>
Date: Sun, 28 Oct 2001 14:20:48 +0100
From: Emmanuel PIERRE <epierre@e-nef.com>
Reply-To: epierre@e-nef.com
Organization: APR-JOB
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: fr-FR, fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CIA machine check reporting "machine check type: processor detected hard 
 error
 	" on alpha ev5.6 kernel 2.4.12
Content-Type: multipart/mixed;
 boundary="------------24A1A5EEA23DF9470F6E2382"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------24A1A5EEA23DF9470F6E2382
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

[1.] CIA machine check reporting "machine check type: processor detected
hard error
" on alpha ev5.6 kernel 2.4.12
[2.] unknown error with dump I didn't had under 2.2.x kernels
[3.] kernel
[4.] 2.4.12 - 2.4.10
[5.] 
[PCI 0/14] RAID-5 host drive 0: Missing drive 0
[PCI 0/14] RAID-5 Host Drive 0 installed (idle)
[PCI 0/14] Array Drive 0: n^G<2>CIA machine check: vector=0x670
pc=0xfffffc00004260ec code=0x98
machine check type: processor detected hard error
pc = [<fffffc00004260ec>]  ra = [<fffffc0000425f98>]  ps = 0007    Not
tainted
v0 = 000000000000fffe  t0 = 0000000000000000  t1 = fffffc01001ed42c
t2 = 00000000fffa941c  t3 = 000000000000000b  t4 = fffffc0000242830
t5 = 0000000000000003  t6 = fffffc00001e7950  t7 = fffffc00001e4000
a0 = fffffc0000520920  a1 = fffffc0000244010  a2 = 0000000000000003
a3 = fffffffffffffffd  a4 = 000000000000ffff  a5 = 0000000000000054
t8 = fffffc000024400c  t9 = fffffc000024317a  t10= 0000000000000028
t11= fffffc0000244005  pv = fffffc000049a6c0  at = 0000000000000000
gp = fffffc000056b910  sp = fffffc00001e78e0
^B
[...]
Freeing unused kernel memory: 296k freed
CIA machine check: vector=0x670 pc=0xfffffc00003120ec code=0x98
machine check type: processor detected hard error
pc = [<fffffc00003120ec>]  ra = [<fffffc0000312108>]  ps = 0000    Not
tainted
v0 = 0000000000000000  t0 = ffffffffffffffff  t1 = 0000000000000000
t2 = 0000000000000001  t3 = fffffc0000532c40  t4 = fffffc0000532c40
t5 = fffffffffffffc18  t6 = fffffc0000570848  t7 = fffffc00004f4000
a0 = 0000000000000019  a1 = 0000000000000032  a2 = 0000000000000002
a3 = 0000000000000002  a4 = fffffc00004f8640  a5 = fffffc0000532c40
t8 = 0000000000000000  t9 = 00000000aed6b1ff  t10= 0000000000000000
t11= fffffc0000de2238  pv = fffffc000031cee0  at = fffffc00004f4000
gp = fffffc000056b910  sp = fffffc00004f7fc0
CIA machine check: vector=0x670 pc=0xfffffc00003120e8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc00003120e8>]  ra = [<fffffc0000312108>]  ps = 0000    Not
tainted
v0 = 0000000000000000  t0 = ffffffffffffffff  t1 = 0000000000000000
t2 = 0000000000000001  t3 = fffffc0000532c40  t4 = fffffc0000532c40
t5 = fffffffffffffc18  t6 = fffffc0000570848  t7 = fffffc00004f4000
a0 = 0000000000000019  a1 = 0000000000000032  a2 = 0000000000000002
a3 = 0000000000000002  a4 = fffffc00004f8640  a5 = fffffc0000532c40
t8 = 0000000000000000  t9 = 00000000c6193945  t10= 0000000000000000
t11= fffffc001fbc3c00  pv = fffffc000031cee0  at = fffffc00004f4000
gp = fffffc000056b910  sp = fffffc00004f7fc0
CIA machine check: vector=0x670 pc=0xfffffc0000499f88 code=0x98
machine check type: processor detected hard error
pc = [<fffffc0000499f88>]  ra = [<fffffc0000355eb8>]  ps = 0000    Not
tainted
v0 = fffffc001f9ec000  t0 = 0000000000001fe8  t1 = 0000000000000000
t2 = 000000000000016f  t3 = 0000000000000000  t4 = fffffc001f9ed468
t5 = fffffc001f9edfed  t6 = fffffc001fdb6000  t7 = fffffc001fab0000
a0 = fffffc001f9ec000  a1 = 0000000000000000  a2 = 0000000000000005
a3 = 0000000000001840  a4 = fffffc00004f8640  a5 = fffffc0000532c40
t8 = 0000000000000000  t9 = fffffc001fab3d98  t10= 9800000000000000
t11= fffffc0000de2038  pv = fffffc0000499f20  at = fffffc0000339d70
gp = fffffc000056b910  sp = fffffc001fab3c58
Adding Swap: 65080k swap-space (priority -1)
[6.] boot process
[7.] 
[7.1.] 
Linux alpha 2.4.12 #2 mar oct 22 15:54:24 CET 2041 alpha unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10f
mount                  2.10r
modutils               2.3.21
e2fsprogs              1.18
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):
cpu         : Alpha
cpu model       : EV56
cpu variation       : 7
cpu revision        : 0
cpu serial number   :
system type     : Noritake
system variation    : 0
system revision     : 0
system serial number    :
cycle frequency [Hz]    : 500000000
timer frequency [Hz]    : 1024.00
page size [bytes]   : 8192
phys. address bits  : 40
max. addr. space #  : 127
BogoMIPS        : 994.44
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc  : 0 (pc=0,va=0)
platform string     : DIGITAL Server 3000 Model 3305 6500A
cpus detected       : 1

[7.3.] Module information (from /proc/modules):

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-0080 : rtc
00a0-00bf : pic2
00c0-00df : dma2
03c0-03df : vga+
9000-90ff : QLogic Corp. ISP1020
  9000-90fe : qlogicisp
9400-94ff : LSI Logic / Symbios Logic (formerly NCR) 53c825
  9400-947f : ncr53c8xx
9800-987f : Digital Equipment Corporation DECchip 21142/43

00000000-1fffffff : HAE0
  02200000-0223ffff : Digital Equipment Corporation DECchip 21142/43
  02240000-0224ffff : QLogic Corp. ISP1020
  02250000-0225ffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
  02260000-02267fff : LSI Logic / Symbios Logic (formerly NCR) 53c825
  02268000-0226ffff : ICP Vortex Computersysteme GmbH GDT 6537RP
  02270000-02273fff : ICP Vortex Computersysteme GmbH GDT 6537RP
  02274000-02274fff : QLogic Corp. ISP1020
  02275000-02275fff : LSI Logic / Symbios Logic (formerly NCR) 53c825
  02276000-022760ff : LSI Logic / Symbios Logic (formerly NCR) 53c825
  02277000-0227707f : Digital Equipment Corporation DECchip 21142/43
  04000000-07ffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]

[7.5.] PCI information ('lspci -vvv' as root)
00:05.0 SCSI storage controller: Q Logic ISP1020 (rev 05)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 17
    Region 0: I/O ports at 9000 [size=256]
    Region 1: Memory at 0000000002274000 (32-bit, non-prefetchable)
[size=4K]
    Expansion ROM at 0000000002240000 [disabled] [size=64K]

00:06.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
(rev 54) (prog-if 00 [VGA])
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin A routed to IRQ 0
    Region 0: Memory at 0000000004000000 (32-bit, non-prefetchable)
[size=64M]
    Expansion ROM at 0000000002250000 [disabled] [size=64K]

00:07.0 Non-VGA unclassified device: Intel Corporation 82375EB (rev 15)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 set

00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 30)
    Subsystem: Digital Equipment Corporation DE500 Fast Ethernet
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 20 min, 40 max, 96 set, cache line size 08
    Interrupt: pin A routed to IRQ 18
    Region 0: I/O ports at 9800 [size=128]
    Region 1: Memory at 0000000002277000 (32-bit, non-prefetchable)
[size=128]
    Expansion ROM at 0000000002200000 [disabled] [size=256K]

00:0d.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c825 (rev 13)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 17 min, 64 max, 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 22
    Region 0: I/O ports at 9400 [size=256]
    Region 1: Memory at 0000000002276000 (32-bit, non-prefetchable)
[size=256]
    Region 2: Memory at 0000000002275000 (32-bit, non-prefetchable)
[size=4K]
    Expansion ROM at 0000000002260000 [disabled] [size=32K]

00:0e.0 SCSI storage controller: ICP Vortex Computersysteme GmbH GDT
6537RP
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 set, cache line size 08
    Interrupt: pin A routed to IRQ 24
    Region 0: Memory at 0000000002270000 (32-bit, prefetchable)
[size=16K]
    Expansion ROM at 0000000002268000 [disabled] [size=32K]


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: DEC      Model: RRD46   (C) DEC  Rev: 1337
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: XP31070W      !x Rev: 81K6
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDRS-34560D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ICP      Model: Host Drive  #00  Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
[X.] Other notes, patches, fixes, workarounds:
--------------24A1A5EEA23DF9470F6E2382
Content-Type: text/plain; charset=us-ascii;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.12 (root@alpha) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 mar oct 22 15:54:24 CET 2041
Booting on Noritake using machine vector Noritake-Primo from SRM
Command line: root=/dev/sda1 bootdevice=scd0 bootfile=kernel-2.4.12
memcluster 0, usage 1, start        0, end      236
memcluster 1, usage 0, start      236, end    65511
memcluster 2, usage 1, start    65511, end    65536
freeing pages 236:384
freeing pages 719:65511
reserving pages 719:720
pci: cia revision 2
On node 0 totalpages: 65511
zone(0): 65511 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda1 bootdevice=scd0 bootfile=kernel-2.4.12
Using epoch = 1980
Console: colour VGA+ 80x25
Calibrating delay loop... 994.44 BogoMIPS
Memory: 511288k/524088k available (1600k kernel code, 10912k reserved, 483k data, 296k init)
Dentry-cache hash table entries: 65536 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 32768 (order: 6, 524288 bytes)
Mount-cache hash table entries: 8192 (order: 4, 131072 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 262144 bytes)
Page-cache hash table entries: 65536 (order: 6, 524288 bytes)
POSIX conformance testing by UNIFIX
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed tbia test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=16
eth0: DE500-BA at 0x9800 (PCI bus 0, device 11), h/w address 00:00:f8:07:f4:31,
      and requires IRQ18 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
Linux Tulip driver version 0.9.15-pre7 (Oct 2, 2001)
PCI: Unable to reserve I/O region #1:80@9800 for device 00:0b.0
Trying to free nonexistent resource <02277000-0227707f>
SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 28 irq 17 I/O base 0x9000
  Vendor: DEC       Model: RRD46   (C) DEC   Rev: 1337
  Type:   CD-ROM                             ANSI SCSI revision: 02
ncr53c8xx: at PCI bus 0, device 13, function 0
ncr53c8xx: 53c825a detected 
ncr53c825a-0: rev 0x13 on pci bus 0 device 13 function 0 irq 22
ncr53c825a-0: ID 7, Fast-10, Parity Checking
scsi1 : ncr53c8xx-3.4.3b-20010512
  Vendor: IBM       Model: XP31070W      !x  Rev: 81K6
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Configuring GDT-PCI HA at 0/14 IRQ 24
[PCI 0/14] GDT6537RP -- HWL0 -- 32 MB EDO-RAM -- 512kB/0kB Flash-RAM
[PCI 0/14] SN 11C033B4 -- RAIDYNE-FW-Version 2.22.10-R01F -- Apr 12 1999
[PCI 0/14] SCSI-C ID:0 LUN:0 -- COMPAQ   ST19171WC       
[PCI 0/14] SCSI-C ID:1 LUN:0 -- SEAGATE  ST19171W        
[PCI 0/14] SCSI-C ID:2 LUN:0 -- SEAGATE  ST39102LC       
[PCI 0/14] SCSI-C ID:3 LUN:0 -- SEAGATE  ST39102LC       
[PCI 0/14] RAID-5 Host Drive 0, Logical Drive 1:
[PCI 0/14] Inconsistencies detected between cache and array drive
[PCI 0/14] configuration data. Updating array drive configuration.
[PCI 0/14] Press return to confirm
[PCI 0/14] 
[PCI 0/14] RAID-5 Host Drive 0, Logical Drive 2:
[PCI 0/14] Inconsistencies detected between cache and array drive
[PCI 0/14] configuration data. Updating array drive configuration.
[PCI 0/14] Press return to confirm
[PCI 0/14] 
[PCI 0/14] RAID-5 host drive 0: Missing drive 0
[PCI 0/14] RAID-5 Host Drive 0 installed (idle)
[PCI 0/14] Array Drive 0: n<2>CIA machine check: vector=0x670 pc=0xfffffc00004260ec code=0x98
machine check type: processor detected hard error
pc = [<fffffc00004260ec>]  ra = [<fffffc0000425f98>]  ps = 0007    Not tainted
v0 = 000000000000fffe  t0 = 0000000000000000  t1 = fffffc01001ed42c
t2 = 00000000fffa941c  t3 = 000000000000000b  t4 = fffffc0000242830
t5 = 0000000000000003  t6 = fffffc00001e7950  t7 = fffffc00001e4000
a0 = fffffc0000520920  a1 = fffffc0000244010  a2 = 0000000000000003
a3 = fffffffffffffffd  a4 = 000000000000ffff  a5 = 0000000000000054
t8 = fffffc000024400c  t9 = fffffc000024317a  t10= 0000000000000028
t11= fffffc0000244005  pv = fffffc000049a6c0  at = 0000000000000000
gp = fffffc000056b910  sp = fffffc00001e78e0

scsi2 : GDT6537RP
  Vendor: ICP       Model: Host Drive  #00   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 6, lun 0
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
ncr53c825a-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)
SCSI device sda: 2199878 512-byte hdwr sectors (1126 MB)
Partition check:
 sda: sda1 sda2
ncr53c825a-0-<6,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 8)
SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
 sdb: sdb1
SCSI device sdc: 35535780 512-byte hdwr sectors (18194 MB)
 sdc: sdc1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (2047 buckets, 16376 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 296k freed
CIA machine check: vector=0x670 pc=0xfffffc00003120ec code=0x98
machine check type: processor detected hard error
pc = [<fffffc00003120ec>]  ra = [<fffffc0000312108>]  ps = 0000    Not tainted
v0 = 0000000000000000  t0 = ffffffffffffffff  t1 = 0000000000000000
t2 = 0000000000000001  t3 = fffffc0000532c40  t4 = fffffc0000532c40
t5 = fffffffffffffc18  t6 = fffffc0000570848  t7 = fffffc00004f4000
a0 = 0000000000000019  a1 = 0000000000000032  a2 = 0000000000000002
a3 = 0000000000000002  a4 = fffffc00004f8640  a5 = fffffc0000532c40
t8 = 0000000000000000  t9 = 00000000aed6b1ff  t10= 0000000000000000
t11= fffffc0000de2238  pv = fffffc000031cee0  at = fffffc00004f4000
gp = fffffc000056b910  sp = fffffc00004f7fc0
CIA machine check: vector=0x670 pc=0xfffffc00003120e8 code=0x98
machine check type: processor detected hard error
pc = [<fffffc00003120e8>]  ra = [<fffffc0000312108>]  ps = 0000    Not tainted
v0 = 0000000000000000  t0 = ffffffffffffffff  t1 = 0000000000000000
t2 = 0000000000000001  t3 = fffffc0000532c40  t4 = fffffc0000532c40
t5 = fffffffffffffc18  t6 = fffffc0000570848  t7 = fffffc00004f4000
a0 = 0000000000000019  a1 = 0000000000000032  a2 = 0000000000000002
a3 = 0000000000000002  a4 = fffffc00004f8640  a5 = fffffc0000532c40
t8 = 0000000000000000  t9 = 00000000c6193945  t10= 0000000000000000
t11= fffffc001fbc3c00  pv = fffffc000031cee0  at = fffffc00004f4000
gp = fffffc000056b910  sp = fffffc00004f7fc0
CIA machine check: vector=0x670 pc=0xfffffc0000499f88 code=0x98
machine check type: processor detected hard error
pc = [<fffffc0000499f88>]  ra = [<fffffc0000355eb8>]  ps = 0000    Not tainted
v0 = fffffc001f9ec000  t0 = 0000000000001fe8  t1 = 0000000000000000
t2 = 000000000000016f  t3 = 0000000000000000  t4 = fffffc001f9ed468
t5 = fffffc001f9edfed  t6 = fffffc001fdb6000  t7 = fffffc001fab0000
a0 = fffffc001f9ec000  a1 = 0000000000000000  a2 = 0000000000000005
a3 = 0000000000001840  a4 = fffffc00004f8640  a5 = fffffc0000532c40
t8 = 0000000000000000  t9 = fffffc001fab3d98  t10= 9800000000000000
t11= fffffc0000de2038  pv = fffffc0000499f20  at = fffffc0000339d70
gp = fffffc000056b910  sp = fffffc001fab3c58
Adding Swap: 65080k swap-space (priority -1)

--------------24A1A5EEA23DF9470F6E2382--

