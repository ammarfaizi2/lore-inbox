Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317013AbSFWMWT>; Sun, 23 Jun 2002 08:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317014AbSFWMWS>; Sun, 23 Jun 2002 08:22:18 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:43486 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S317013AbSFWMWQ>;
	Sun, 23 Jun 2002 08:22:16 -0400
Message-Id: <200206231224.g5NCO7S27331@toxic.rt.mipt.ru>
Content-Type: text/plain; charset=US-ASCII
From: toxic <toxic@rt.mipt.ru>
Reply-To: toxic@rt.mipt.ru
Organization: mipt
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: shot-like sound during recording from line-in
Date: Sun, 23 Jun 2002 16:23:57 +0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

1. One line summary of the problem: shot-like sound during recording from 
line-in
2. Full description of the problem/report: when i'm trying to record a stream 
from my bttv card connected wit on-board soundcard i hear that sound 
pulse-like or may be even shot-like
3. Keywords sound 
4. Linux version 2.4.18 (root@ip82-152.rt.mipt.ru) (gcc version 2.96 20000731 
(Red Hat Linux 7.3 2.96-110)) #1 SMP Wed Jun 19 07:20:16 $
5.
6. ffmpeg triggers that problem
7.
7.1 Linux ip82-152.rt.mipt.ru 2.4.18 #1 SMP Wed Jun 19 07:20:16 MSD 2002 i686 
unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
7.2 processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1333.439
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2660.76
7.3 no modules
7.4 iomem:00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00269862 : Kernel code
  00269863-002c77bf : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
dd800000-dd8fffff : PCI Bus #01
dd9fb000-dd9fbfff : Intel Corp. 82557 [Ethernet Pro 100]
  dd9fb000-dd9fbfff : eepro100
dd9fc000-dd9fcfff : Brooktree Corporation Bt878 (#2)
  dd9fc000-dd9fcfff : bttv
dd9fd000-dd9fdfff : Brooktree Corporation Bt878 (#2)
dd9fe000-dd9fefff : Brooktree Corporation Bt878
  dd9fe000-dd9fefff : bttv
dd9ff000-dd9fffff : Brooktree Corporation Bt878
dda00000-dfafffff : PCI Bus #01
  de000000-deffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  dfaff000-dfafffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
dff00000-dfffffff : Intel Corp. 82557 [Ethernet Pro 100]
e0000000-e3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
ioports: 0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0c00-0c7f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
8000-9fff : PCI Bus #01
  9800-98ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
c400-c41f : Intel Corp. 82557 [Ethernet Pro 100]
  c400-c41f : eepro100
c800-c83f : Ensoniq 5880 AudioPCI
  c800-c83f : es1371
cc00-cc1f : VIA Technologies, Inc. UHCI USB
  cc00-cc1f : usb-uhci
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
  d000-d01f : usb-uhci
d400-d403 : VIA Technologies, Inc. AC97 Audio Controller
  d400-d403 : via82cxxx_audio
d800-d803 : VIA Technologies, Inc. AC97 Audio Controller
  d800-d803 : via82cxxx_audio
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
  dc00-dcff : via82cxxx_audio
ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

- -- 
yo! wasssap!!!!
this msg written by T_o_X_i_C ! 
Visit our site http://www.clipzone.mipt.ru/ 
<:. CLIPZONE - World of Music & Video .:>
public key stored
@ http://www.2ka.mipt.ru/~toxic/pkey/toxic.gnupg
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Fb3kkr6ycP871PcRAl6VAJ4vOzi64G7WuI5F35W/t/G0E4KprQCeIsVb
ihVPV6gVPdEAQJWqTXU4Bsw=
=VZ5N
-----END PGP SIGNATURE-----
