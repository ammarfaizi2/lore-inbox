Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130219AbRBSOvp>; Mon, 19 Feb 2001 09:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130628AbRBSOvh>; Mon, 19 Feb 2001 09:51:37 -0500
Received: from [200.43.18.234] ([200.43.18.234]:16648 "EHLO
	radius.telpin.com.ar") by vger.kernel.org with ESMTP
	id <S130219AbRBSOva>; Mon, 19 Feb 2001 09:51:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops attachments
Message-ID: <982594213.3a9132a5e57ed@webmail.telpin.com.ar>
Date: Mon, 19 Feb 2001 11:50:13 -0300 (ARST)
From: Alberto Bertogli <albertogli@telpin.com.ar>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ9825942136ae3687f7b15d2a0092b76925b36ad9a"
User-Agent: IMP/PHP IMAP webmail program 2.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ9825942136ae3687f7b15d2a0092b76925b36ad9a
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Sorry, i had a little problem sending the attachments in my last email.
Here they are.

Thanks again,
        Alberto
---MOQ9825942136ae3687f7b15d2a0092b76925b36ad9a
Content-Type: text/plain; name="dmesg"; name="dmesg"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="dmesg"


Linux version 2.4.1 (root@sol) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 SMP Wed Feb 14 18:14:33 ARST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000fdba0
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: POWEREDGE    APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is EISA  
I/O APIC #1 Version 17 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID 1, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 1, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 1, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 1, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 1, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 1, APIC INT 05
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 1, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 1, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 1, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 1, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 1, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 1, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 1, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 1, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 1, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 1, APIC INT 0f
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=linux ro root=801
Initializing CPU#0
Detected 199.438 MHz processor.
Console: colour VGA+ 132x44
Calibrating delay loop... 397.31 BogoMIPS
Memory: 125404k/131072k available (1865k kernel code, 5280k reserved, 649k data, 212k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
CPU0: Intel Pentium Pro stepping 07
per-CPU timeslice cutoff: 1460.32 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 3000000
Getting ID: c000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 9
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 0) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 398.13 BogoMIPS
Stack at about c1229fbc
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium Pro stepping 07
CPU has booted.
Before bogomips.
Total of 2 processors activated (795.44 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 1 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 16.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  1    1    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  1    1    0   0   0    1    1    91
 0f 003 03  1    1    0   0   0    1    1    99
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 199.4404 MHz.
..... host bus clock speed is 66.4798 MHz.
cpu: 0, clocks: 664798, slice: 221599
CPU0<T0:664784,T1:443184,D:1,S:221599,C:664798>
cpu: 1, clocks: 664798, slice: 221599
CPU1<T0:664784,T1:221584,D:2,S:221599,C:664798>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf814d, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83208kB/27736kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
divert: not allocating divert_blk for non-ethernet device teql0
early initialization of device teql0 is deferred
NET4: Frame Diverter 0.46
Coda Kernel/Venus communications, v5.3.9, coda@cs.cmu.edu
NTFS version 000607
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
divert: allocating divert_blk for eth0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:2D:E5:16, IRQ 14.
  Board assembly 352509-003, Physical connectors present: RJ45
  Primary interface chip DP83840 PHY #1.
  DP83840 specific setup, setting register 23 to 8462.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
divert: not allocating divert_blk for non-ethernet device shaper0
divert: not allocating divert_blk for non-ethernet device dummy0
divert: not allocating divert_blk for non-ethernet device bond0
Universal TUN/TAP device driver 1.3 (C)1999-2000 Maxim Krasnyansky
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 1/10/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
(scsi1) <Adaptec AIC-7860 Ultra SCSI host adapter> found at PCI 1/11/0
(scsi1) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi1) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7880 Ultra SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7860 Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 20.0 Mbyte/sec, offset 8.
  Vendor: QUANTUM   Model: ATLAS IV 18 WLS   Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: NEC       Model: CD-ROM DRIVE:462  Rev: 1.14
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:0:5:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SONY      Model: TSL-9000          Rev: L006
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: SONY      Model: TSL-9000          Rev: L006
  Type:   Medium Changer                     ANSI SCSI revision: 02
Detected scsi tape st0 at scsi1, channel 0, id 5, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
Partition check:
 sda: sda1 sda2
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 3, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Detected scsi generic sg3 at scsi1, channel 0, id 5, lun 1, type 8
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IPv4 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device tunl0
GRE over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device gre0
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
ip6_tables: (c)2000 Netfilter core team
registreing ipv6 mark target
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Adding Swap: 666688k swap-space (priority -1)
megaraid: v107 (December 22, 1999)
megaraid: found 0x101e:0x9010: in 01:0d.0
scsi2 : Found a MegaRAID controller at 0xe090, IRQ: 15
megaraid: Couldn't register I/O range!
megaraid: v107 (December 22, 1999)
megaraid: found 0x101e:0x9010: in 01:0d.0
scsi2 : Found a MegaRAID controller at 0xe090, IRQ: 15
megaraid: [U.75:1.44] detected 1 logical drives
scsi2 : AMI MegaRAID U.75 254 commands 16 targs 2 chans 8 luns
scsi2: scanning channel 1 for devices.
  Vendor: DELL      Model: 6UW BACKPLANE     Rev: 7   
  Type:   Processor                          ANSI SCSI revision: 02
Detected scsi generic sg4 at scsi2, channel 0, id 6, lun 0, type 3
scsi2: scanning channel 2 for devices.
scsi2: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5  8176R  Rev: U.75
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi2, channel 2, id 0, lun 0
SCSI device sdb: 16744448 512-byte hdwr sectors (8573 MB)
 sdb: sdb1
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
eth0: no IPv6 routers present
mailsnarf uses obsolete (PF_INET,SOCK_PACKET)
device eth0 entered promiscuous mode
keyboard: unknown scancode e0 73

---MOQ9825942136ae3687f7b15d2a0092b76925b36ad9a
Content-Type: text/plain; name="ksymoops"; name="ksymoops"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="ksymoops"


ksymoops 2.3.7 on i686 2.4.1.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1/ (default)
     -m /boot/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 00100:[<c11e07d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c37d3d64  ebx: c37d3d64  ecx: 00000202  edx: 00000000
esi: c03d29ec  edi: 00000001  ebp: c37d3d64  esp: c49fdcb0
ds: 0018  es: 0018  ss: 0018
Stack:  c49fc000 c03d29ec c028dea6 c37d3d64 c49fc000 c03d29ec 00000001 c5c4d0b6
        c49fc000 c028e9a6 c37d3d20 02932e00 c37d3d20 c2d94ea0 c036fe80 c49fdddc
        00000054 c028bf05 c49fc000 00000001 00000001 c028fcdc c37d3d20 c5c4d0a8
Call Trace: [<c028dea6>] [<c028e9a6>] [<c028bf05>] [<c028cfdc>] [<fe122bc8>] [<f0122bc8>] [<c028b2a6>] 
        [<c0266ccc>] [<c024d344>] [<c0266ccc>] [<c024d628>] [<c0266ccc>] [<c0265dbf>] [<c0266ccc>] [<c0272748>] 
        [<c0272ce6>] [<c012c031>] [<c027337b>] [<c0269f91>] [<c0282a30>] [<c0282a6a>] [<c0242651>] [<c0282a30>] 
        [<c024286b>] [<c013439e>] [<c0108fc7>] 
Code: 89 5a 04 89 13 89 43 04 89 18 c6 05 40 62 35 c0 01 51 9d eb

>>EIP; 0c11e07d Before first symbol   <=====
Trace; c028dea6 <ip_ct_refresh+d2/130>
Trace; c028e9a6 <tcp_packet+25e/270>
Trace; c028bf05 <ip_conntrack_find_get+4d/f8>
Trace; c028cfdc <ip_conntrack_in+298/324>
Trace; fe122bc8 <END_OF_CODE+358b9e65/????>
Trace; f0122bc8 <END_OF_CODE+278b9e65/????>
Trace; c028b2a6 <ip_conntrack_local+56/5c>
Trace; c0266ccc <ip_queue_xmit2+0/1e4>
Trace; c024d344 <nf_iterate+30/88>
Trace; c0266ccc <ip_queue_xmit2+0/1e4>
Trace; c024d628 <nf_hook_slow+b0/158>
Trace; c0266ccc <ip_queue_xmit2+0/1e4>
Trace; c0265dbf <ip_queue_xmit+257/2c8>
Trace; c0266ccc <ip_queue_xmit2+0/1e4>
Trace; c0272748 <tcp_cwnd_restart+18/9c>
Trace; c0272ce6 <tcp_transmit_skb+51a/5d8>
Trace; c012c031 <kfree+89/94>
Trace; c027337b <tcp_write_xmit+18f/2dc>
Trace; c0269f91 <tcp_sendmsg+9b5/bd0>
Trace; c0282a30 <inet_sendmsg+0/40>
Trace; c0282a6a <inet_sendmsg+3a/40>
Trace; c0242651 <sock_sendmsg+81/a4>
Trace; c0282a30 <inet_sendmsg+0/40>
Trace; c024286b <sock_write+9f/a8>
Trace; c013439e <sys_write+8e/c4>
Trace; c0108fc7 <system_call+33/38>
Code;  0c11e07d Before first symbol
00000000 <_EIP>:
Code;  0c11e07d Before first symbol   <=====
   0:   89 5a 04                  movl   %ebx,0x4(%edx)   <=====
Code;  0c11e080 Before first symbol
   3:   89 13                     movl   %edx,(%ebx)
Code;  0c11e082 Before first symbol
   5:   89 43 04                  movl   %eax,0x4(%ebx)
Code;  0c11e085 Before first symbol
   8:   89 18                     movl   %ebx,(%eax)
Code;  0c11e087 Before first symbol
   a:   c6 05 40 62 35 c0 01      movb   $0x1,0xc0356240
Code;  0c11e08e Before first symbol
  11:   51                        pushl  %ecx
Code;  0c11e08f Before first symbol
  12:   9d                        popf   
Code;  0c11e090 Before first symbol
  13:   eb 00                     jmp    15 <_EIP+0x15> 0c11e092 Before first symbol

Kernel panic: Aiee, killing interrupt handler!

---MOQ9825942136ae3687f7b15d2a0092b76925b36ad9a
Content-Type: text/plain; name="oops"; name="oops"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="oops"


Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 00100:[<c11e07d>]
EFLAGS: 00010082
eax: c37d3d64  ebx: c37d3d64  ecx: 00000202  edx: 00000000
esi: c03d29ec  edi: 00000001  ebp: c37d3d64  esp: c49fdcb0
ds: 0018  es: 0018  ss: 0018
Process httpd (pid: 76, stackpage = c49fd000)
Stack:	c49fc000 c03d29ec c028dea6 c37d3d64 c49fc000 c03d29ec 00000001 c5c4d0b6
	c49fc000 c028e9a6 c37d3d20 02932e00 c37d3d20 c2d94ea0 c036fe80 c49fdddc
	00000054 c028bf05 c49fc000 00000001 00000001 c028fcdc c37d3d20 c5c4d0a8
Call Trace: [<c028dea6>] [<c028e9a6>] [<c028bf05>] [<c028cfdc>] [<fe122bc8>] [<f0122bc8>] [<c028b2a6>] 
	[<c0266ccc>] [<c024d344>] [<c0266ccc>] [<c024d628>] [<c0266ccc>] [<c0265dbf>] [<c0266ccc>] [<c0272748>] 
	[<c0272ce6>] [<c012c031>] [<c027337b>] [<c0269f91>] [<c0282a30>] [<c0282a6a>] [<c0242651>] [<c0282a30>] 
	[<c024286b>] [<c013439e>] [<c0108fc7>] 

Code: 89 5a 04 89 13 89 43 04 89 18 c6 05 40 62 35 c0 01 51 9d eb

Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


---MOQ9825942136ae3687f7b15d2a0092b76925b36ad9a
Content-Type: text/plain; name="linux-2.4.1-config"; name="linux-2.4.1-config"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="linux-2.4.1-config"


#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IPV6=y
# CONFIG_IPV6_EUI64 is not set

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MARK=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y
CONFIG_KHTTPD=y
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_CSZ=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_POLICE=y

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_IDEDMA_PCI is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
# CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT is not set
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_PROC_STATS=y
CONFIG_AIC7XXX_RESET_DELAY=5
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_MEGARAID=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
CONFIG_BONDING=y
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139TOO is not set
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=y

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

---MOQ9825942136ae3687f7b15d2a0092b76925b36ad9a--
