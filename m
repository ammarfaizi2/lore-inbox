Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWFOMRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWFOMRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWFOMRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:17:22 -0400
Received: from flexserv.de ([213.239.215.214]:49849 "EHLO lion.flexserv.de")
	by vger.kernel.org with ESMTP id S1030298AbWFOMRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:17:21 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc6 panic on E420R
Organization: Flexserv
From: daniel+devel.linux.lkml@flexserv.de
X-GPG-ID: 0x7B196671
X-GPG-FP: A9CE 5788 44D3 A1A2 46B6  A727 53D8 DD4B 7B19 6671
X-message-flag: Formating hard disk. please wait...   10%...   20%...
Date: Thu, 15 Jun 2006 14:17:07 +0200
Message-ID: <87r71q1um4.fsf@xserver.flexserv.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

<#secure method=pgpmime mode=sign>
Please tell me how i can help you to fix/ what additional info you need

Daniel


{0} ok reset-all
Resetting ...

screen not found.
Can't open input device.
Keyboard not present.  Using ttya for input and output.

Sun Enterprise 420R (4 X UltraSPARC-II 450MHz), No Keyboard
OpenBoot 3.31, 4096 MB memory installed, Serial #15738865.
Ethernet address 8:0:20:f0:27:f1, Host ID: 80f027f1.
Initializing Memory
Boot device: /pci@1f,4000/scsi@3/disk@0,0 File and args:
SILO Version 1.4.9
boot:
Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.17

Remapping the kernel... done.
Booting Linux...
                                                                    PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:35'
PROMLIB: Root node compatible:
Linux version 2.6.17-rc6 (root@bilbao) (gcc version 3.3.5 (Debian
1:3.3.5-13)) #1 SMP Thu Jun 15 13:29:57 CEST 2006
ARCH: SUN4U
Ethernet address: 08:00:20:f0:27:f1
Built 1 zonelists
Kernel command line: root=/dev/sda2 ro
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Memory: 4152016k available (3864k kernel code, 1088k data, 200k init)
[fffff80000000000,00000000fff44000]
Calibrating delay using timer specific routine.. 900.52 BogoMIPS
(lpj=1801046)
Mount-cache hash table entries: 512
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(4194304):line_sz(64)]
Calibrating delay using timer specific routine.. 900.10 BogoMIPS
(lpj=1800215)
CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(4194304):line_sz(64)]
CPU 1: synchronized TICK with master CPU (last diff -1 cycles,maxerr 546
cycles)
Calibrating delay using timer specific routine.. 900.10 BogoMIPS
(lpj=1800209)
CPU[2]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(4194304):line_sz(64)]
CPU 2: synchronized TICK with master CPU (last diff -2 cycles,maxerr 546
cycles)
Calibrating delay using timer specific routine.. 900.10 BogoMIPS
(lpj=1800212)
CPU[3]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(4194304):line_sz(64)]
CPU 3: synchronized TICK with master CPU (last diff 2 cycles,maxerr 546
cycles)
Brought up 4 CPUs
Total of 4 processors activated (3600.84 BogoMIPS).
migration_cost=35022
NET: Registered protocol family 16
PCI: Probing for controllers.
PCI: Found PSYCHO, control regs at 000001fe00000000
PSYCHO: Shared PCI config space at 000001fe01000000
PCI-IRQ: Routing bus[ 0] slot[ 1] to INO[21]
PCI-IRQ: Routing bus[ 0] slot[ 3] to INO[20]
PCI-IRQ: Routing bus[ 0] slot[ 3] to INO[26]
PCI0(PBMB): Bus running at 33MHz
PCI0(PBMA): Bus running at 66MHz
ebus0: [auxio] [power] [SUNW,pll] [sc] [se] [su] [su] [ecpp] [fdthree]
[eeprom] [flashprom]
power: Control reg at 000001fff1724000 ... powerd running.
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 1048576 bytes)
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with ACLs, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Console: switching to mono PROM 80x34
rtc_init: no PC rtc found
su0 at 0x000001fff13062f8 (irq = 5,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
ttyS0 at MMIO 0x1fff1400000 (irq = 9599840) is a SAB82532 V3.2
Console: ttyS0 (SAB82532)
ttyS1 at MMIO 0x1fff1400040 (irq = 9599840) is a SAB82532 V3.2
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
sunhme.c:v2.02 8/24/03 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:f0:27:f1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
spitfire_data_access_exception: SFSR[00000000001d1039]
SFAR[0000015001600175], going.
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(1): Dax [#1]
TSTATE: 0000009980001601 TPC: 000000000070917c TNPC: 0000000000709180 Y:
00000000    Not tainted
TPC: <fdomain_isa_detect+0x23c/0x2e0>
g0: 0000000000940000 g1: 0000000000000005 g2: 0000000000000000 g3:
0140015001600175
g4: fffff800ffefdc00 g5: fffff7ffffa94000 g6: fffff800ffea8000 g7:
0000000000000032
o0: 000000000087ce88 o1: 0000000000000038 o2: 0000000000000000 o3:
0140015001600170
o4: 000000000087ced8 o5: 000000000081b1d0 sp: fffff800ffeab1e1 ret_pc:
000000000087ced8
RPC: <0x87ced8>
l0: 0000000000000000 l1: 0000000000874820 l2: 0000000000000007 l3:
00000000009829f8
l4: 000000000094fc00 l5: 0000000000940000 l6: 0000000000000000 l7:
00000000009829f8
i0: 00000000009829f8 i1: 00000000009829d0 i2: fffff800ffeabb58 i3:
000000000000000a
i4: 0000000000000073 i5: 0000000000000073 i6: fffff800ffeab2a1 i7:
00000000007095e4
I7: <__fdomain_16x0_detect+0x2c4/0x300>
Caller[00000000007095e4]: __fdomain_16x0_detect+0x2c4/0x300
Caller[0000000000709640]: fdomain_16x0_detect+0x20/0x40
Caller[0000000000903e6c]: init_this_scsi_driver+0x2c/0x100
Caller[00000000008e4964]: do_initcalls+0x44/0x160
Caller[0000000000416f54]: init+0x54/0x1a0
Caller[00000000004188b0]: kernel_thread+0x30/0x60
Caller[0000000000416e50]: rest_init+0x10/0x40
Instruction DUMP: da5b0000  ce03200c  8602c001 <c488c3a0> 8600e001
c20b4000  8408a0ff  80a04002  1240001c
Kernel panic - not syncing: Attempted to kill init!
 <0>Press Stop-A (L1-A) to return to the boot prom

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkU/FU9jdS3sZZnERAjZQAJ4jIx5baTCKctMDWhtulP83mi1PxACfYV3j
/5dTGY1u8OOV22irpI1PLeY=
=Eh3C
-----END PGP SIGNATURE-----
--=-=-=--

