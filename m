Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265858AbSKBBxi>; Fri, 1 Nov 2002 20:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265859AbSKBBxi>; Fri, 1 Nov 2002 20:53:38 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:17604 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265858AbSKBBxa> convert rfc822-to-8bit; Fri, 1 Nov 2002 20:53:30 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Subject: [ANNOUNCE] [PATCH] Linux-2.5.45-mcp2
Date: Sat, 2 Nov 2002 02:55:05 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211020255.05597.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

point me to/send me the fixes/patches you want to see in here please!

here we go, -mcp2 for 2.5.45 vanilla.


 o indicates new add/update
 - indicates removed


 Changes in 2.5.45-mcp2:
 -----------------------
 o  CPU-Freq updates (latest) for 2.5.45                (Dominik Brodowski)
 o  ACPI as from 2002-11-01                             (ACPI Team)
 o  net/ipv4/ipmr.c compile error                       (Adam J. Richter)
 o  neofb v0.4.1                                        (Denis Oliver Kropp)
 o  Filesystem capabilities v0.9                        (Olaf Dietsche)
 o  Real NTFS unresolved symbol                         (Rusty Russell)
 o  Allow IDE to compile without DMA                    (Phil Oester)


 Changes in 2.5.45-mcp1:
 -----------------------
 o  2.5.45-shpte-stuff                                  (Andrew Morton)
 o  Don't bother us with missing QT headers             (Fernando Alencar)
 o  Ext2/Ext3 Extended Attributes, ACL's                (Theodore Ts'o)
 o  Filesystem capabilities                             (Olaf Dietsche)
 o  deadline-ioscheduler-rb-tree-sort                   (Jens Axboe)
 o  dcache-RCU / Files-Struct-RCU                       (Dipankar Sarma)
 o  Devicemapper Fixes                                  (Joe Thornber)
 o  ReiserFS v4                                         (Namesys)
 o  tv tuner driver update                              (Gerd Knorr)
 o  videobuf update                                     (Gerd Knorr)
 o  v4l2: v4l1 compatibility helper module              (Gerd Knorr)
 o  v4l2: API                                           (Gerd Knorr)
 o  BTTV Documentation update                           (Gerd Knorr)
 o  kmalloc_percpu                                    (Ravikiran G Thirumalai)
 o  AFS compile error                                   (Jan Marek)
 o  K-Exec                                              (Eric W. Biederman)
 o  K-Probes                                            (Rusty Russell)
 o  Kernel Mode Linux                                   (Toshiyuki Maeda)
 o  make netfilter's ipt_TCPMSS compile again           (Stelian Pop)
 o  Mobile IPv6 for v2.5.45                             (MIPL Team)
 o  initrd dynamic                                      (Dave Cinege)
 o  znet updates                                        (Marc Zyngier)
 o  fix APIC errors on oprofile restore                 (Philippe Elie)
 o  Intel Compiler fix                                  (Nakajima, Jun)
 o  NTFS unresolved symbol                              (Pawel Kot)
 -  2.5.35-lsm1 (making 2.5.45 patches available may be good)
 -  core file naming (now in mainline)
 -  Large Block Devices (now in mainline)
 -  O-Profiling (now in mainline)
 -  ilookup() (now in mainline)
 -  ALSA fixes (now in mainline)
 -  -ac tree (N/A for 2.5.45 right now)
 -  KDB 2.3 (no 2.5.45 version available)
 -  AccessFS (no 2.5.45 version available)


 Changes in 2.5.40-mcp3:
 -----------------------
 o  2.5.40-ac2                                          (Alan Cox)
 o  more remove-irqlock                                 (Carlos E Gorges)
 o  fix apm (module) unresolved symbol                  (Carlos E Gorges)
 -  SHM fix for OOM issue with Oracle DB (in -ac2)
 -  AMD 768 Random Number Generator (RNG) (in -ac2)
 -  Fix abuse of set_bit in atp (in -ac2)
 -  Stick tulip back under 10/100 ethernet (in -ac2)
 -  random fixes (in -ac2)
 -  vfat corruption fix (in -ac2)
 -  kbuild fix (in -ac2)


 Changes in 2.5.40-mcp2:
 -----------------------
 o  SHM fix for OOM issue with Oracle DB               (Hugh Dickins)
 o  O-Profiling                                        (John Levon)
 o  trivial video/Config.in fix                        (John Levon)
 o  2nd ALSA update (10/12) (now ALSA v0.9.0rc3)       (ALSA Team)
 o  ALSA fix                                           (ALSA Team)
 o  vfat corruption fix                                (Petr Vandrovec)
 o  kbuild fix                                         (Adrian Bunk)
 o  KDB v2.3                                           (SGI)
 o  Large Block Devices (5/5)                          (Peter Chubb)
 o  APIC build fix when APIC is not selected           (Carlos E Gorges)
 o  random fixes                                       (Carlos E Gorges)
 o  AMD 768 Random Number Generator (RNG)              (Alan Cox)
 o  Fix abuse of set_bit in atp                        (Alan Cox)
 o  Stick tulip back under 10/100 ethernet             (Alan Cox)
 o  JFS and CONFIG_PREEMPT fix                         (David Kleikamp)


 Changes in 2.5.40-mcp1:
 -----------------------
 o  2.5.40-mm1                                          (Andrew Morton)
 o  Enterprise Volume Management System (EVMS) v1.2.0   (IBM)
     fix drivers/block/genhd.c before using!
 o  Fix menuconfig error for ALSA                       (me)
 o  ilookup() for searching for inodes in icache (2/2)  (Anton Altaparmakov)
 -  ALSA Updates 10/10 (now in 2.5.40)
 -  i8xx series chipsets patches (3/3)  (now in 2.5.40)
 -  CPU-Frequency scaling fix (now in 2.5.40)
 -  sg.c and USER_HZ (now in 2.5.40)
 -  xtime to do_gettimeofday() (now in 2.5.40)
 -  net/Config.in (IPX, Appletalk) (now in 2.5.40)
 -  SMB fixes (3/3) (now in 2.5.40)
 -  remove fat_search_long() in vfat_add_entry() (now in 2.5.40)
 -  use fff/ffff/fffffff instead
     of ff8/fff8/ffffff8 for EOF of FAT (now in 2.5.40)
 -  sigfix-2.5.39-D0 (now in 2.5.40)
 -  RCU fixes for 2.5.39-mm1 (now in 2.5.40-mm1)


 Changes in 2.5.39-mcp1:
 -----------------------
 o  2.5.39-mm1                                          (Andrew Morton)
 o  RCU fixes for 2.5.39-mm1                            (Dipankar Sarma)
 o  ReiserFS temporary fix for 2.5.39-mm1               (Andrew Morton)
 o  CPU-Frequency scaling fix 2.5.39                    (Dominik Brodowski)
 o  ALSA Updates 10/10                                  (Jaroslav Kysela)
 o  ALSA Update fix                                     (Arador)
 o  i8xx series chipsets patches (3/3)                  (Wim Van Sebroeck)
 o  sg.c and USER_HZ, kernel 2.5.39                     (Rolf Fokkens)
 o  timer.c negative shift, kernel 2.5.39               (Rolf Fokkens)
 o  net/Config.in (IPX, Appletalk)                      (Andries Brouwer)
 o  SMB fixes (3/3)                                     (Urban Widmark)
 o  use fff/ffff/fffffff instead
     of ff8/fff8/ffffff8 for EOF of FAT                 (Ogawa Hirofumi)
 o  remove fat_search_long() in vfat_add_entry()        (Ogawa Hirofumi)
 o  sigfix-2.5.39-D0                                    (Ingo Molnar)
 -  ReiserFS fix (now in 2.5.39)


 Changes in 2.5.38-mcp3:
 -----------------------
 o  2.5.38-mm3                                          (Andrew Morton)
 o  ReiserFS fix                                        (Hans Reiser)
 o  include missing in drivers/usb/host/ohci-hcd.c      (Luc Van Oostenryck)
 o  AccessFS 2.5.35[8]-0.5                              (Olaf Dietsche)
 o  files_struct_rcu patch for 2.5.38                   (Dipankar Sarma)
 o  Rename "Second extended fs" to
     "Ext2 file system support"                         (me)
 o  Moved every Journalling Filesystem in
     an extra menu option                               (me)
 -  UP_APIC linkage problem fix (now in -mmX)
 -  2.5.38 EBTables breakage fix (now in -mmX)
 -  2.5.38 floppy build problem fix (now in -mmX)
 -  oops at boot in ide_toggle_bounce fix (now in -mmX)


 Changes in 2.5.38-mcp2:
 -----------------------
 o  2.5.38-mm2                                          (Andrew Morton)
 o  AccessFS 2.5.34-0.4                                 (Olaf Dietsche)
 o  export find_task_by_pid fix                         (Hiroshi Takekawa)
 o  make bzImage fails on 2.5.38                        (Hiroshi Takekawa)
 o  xtime to do_gettimeofday() in drivers/atm/*c        (Francois Romieu)
 o  drivers/char/sx.c __FUNCTION__ breakage fix         (Adrian Bunk)
 o  drivers/char/generic_serial.c __FUNCTION__ fix      (Adrian Bunk)
 o  UP_APIC linkage problem fix                         (Mikael Pettersson)
 o  CPU-Frequency scaling for 2.5.38                    (Dominik Brodowski)
 o  2.5.38 floppy build problem fix                     (Philipp M. Hahn)
 o  2.5.38 EBTables breakage fix                        (Bert Hubert)
 o  sound/oss cli() fixup all in one fix                (Peter Waechtler)
 o  oopses at boot in ide_toggle_bounce fix             (Jens Axboe)
 o  IDE oopses on vmware fix                            (Jens Axboe)
 -  schedule in_atomic() check (now in 2.5.38)
 -  recognize MAP_LOCKED in mmap() call (in 2.5.38)
 -  clean up RPC over TCP transport (now in 2.5.38)
 -  RCU (Read-Copy Update) 2.5.36 (now in -mmX)


 Changes in 2.5.36-mcp2:
 -----------------------
 o  RCU (Read-Copy Update) for 2.5.36 + Fix             (Dipankar Sarma)
 o  real preempt <-> mmX fix (not a workaround :)       (Robert Love)
      thnx to Steven Cole <elenstev@mesatop.com>
      for pointing me to the real fix :)
 o  recognize MAP_LOCKED in mmap() call                 (Hubertus Franke)
 o  core file naming                                    (Jes Rahbek Klinke)
      This is in the WOLK series for a long time now
      and I really like this feature and want to see
      this in 2.5.xx mainline! :)
 o  clean up RPC over TCP transport socket connect      (Chuck Lever)
 o  CPU-Frequency scaling for 2.5.36                    (Dominik Brodowski)


 Changes in 2.5.36-mcp1:
 -----------------------
 o  2.5.36-mm1                                          (Andrew Morton)
 o  2.5.35-lsm1 (Linux Security Module)                 (LSM Team)
 o  2.5.36 i2c core drivers module_init/exit cleanup    (Albert Cranford)
 o  2.5.36 i2c new adapter id's                         (Albert Cranford)
 o  2.5.36 i2c new adapter i2c-pport driver             (Albert Cranford)
 -  XFS (now in 2.5.36, finally :))
 -  thread-exec-fix-2.5.35-A5 (now in 2.5.36)
 -  ebtables - Ethernet bridge tables (now in 2.5.36)
 -  NTFS unresolved symbol fix (now in 2.5.36)


 Changes in 2.5.35-mcp1:
 -----------------------
 o  2.5.35-mm1                                          (Andrew Morton)
 o  ebtables - Ethernet bridge tables, for 2.5.35       (Bart De Schuymer)
 o  XFS DMAPI compile fix                               (Thunder f. the hill)
 o  ptrace breakage fix (2nd try :)                     (Ogawa Hirofumi)
 o  thread-exec-fix-2.5.35-A5                           (Ingo Molnar)
 o  NTFS - module build - unresolved symbol fix         (me)
 -  INPUT Fixes (7/7) (for now in 2.5.35)


 Changes in 2.5.34-mcp4:
 -----------------------
 o   2.5.34-mm4                                         (Andrew Morton)
 o   ALSA v0.9.0rc3                                     (ALSA Team)
      thanks to Martin Loschwitz for re-integrating this
 o   INPUT Fixes (7/7)                                  (Vojtech Pavlik)
 o   Preempt <-> -mmX workaround                        (Steven Cole)


 Changes in 2.5.34-mcp3:
 -----------------------
 o   2.5.34-mm3                                         (Andrew Morton)


 Changes in 2.5.34-mcp2:
 -----------------------
 o   2.5.34-mm2                                         (Andrew Morton)
 o   Low level fb console driver for VGA text mode      (Petr Vandrovec)
 o   Entropy Fixes (11/11)                              (Oliver Xymoron)
 o   Preempt - no more spurious warnings at reboot/halt (Robert Love)
 o   IRQ-stack 4kb                                      (Dave Hansen)
 -   ftape damage fix (for now in -mm2)
 -   floppy driver init/exit fixes (for now in -mm2)
 -   devfs fix (for now in -mm2)
 -   do_syslog__down_try lock lockup (for now in -mm2)
 -   ALSA v0.9.0rc3
      causes non-compilable sound module with devfs


 Changes in 2.5.34-mcp1:
 -----------------------
 o   2.5.34-mm1                                         (Andrew Morton)
 o   ftape damage fix                                   (Mikael Pettersson)
 o   floppy driver init/exit fixes                      (Mikael Pettersson)
 o   ALSA v0.9.0rc3                                     (ALSA Team)
 o   XFS + KDB (2.5.33-20020908-cvs)                    (XFS Team)
 o   aty128 Framebuffer fixes                           (Paul Mackerras)
 o   devfs fix                                          (Alexander Viro)
 o   do_syslog__down_try lock lockup                    (Ingo Molnar)
 o   pcibios_fixup_irqs-static                          (Adam J. Richter)
 o   ext3 version information fix                       (me)
 o   some tuning                                        (me)
     - OPEN_MAX 1024
     - NR_FILE 65536
     - NR_RESERVED_FILES 128
     - TCP_KEEPALIVE_TIME (5*60*HZ)
     - int sysctl_local_port_range[2] = { 1024, 9999 };


If anyone is interrested in seperated patches of each above I'll
make a patch SET also available!


md5sums:
--------
80ac41fcef35caf16c7b8d018f2f01d3 *linux-2.5.45-mcp2.patch.bz2
803b705389f783f44a350f34a81459b2 *linux-2.5.45-mcp2.patch.gz


URL:
----
http://prdownloads.sf.net/wolk/linux-2.5.45-mcp2.patch.bz2?download
http://prdownloads.sf.net/wolk/linux-2.5.45-mcp2.patch.gz?download


Thanks goes out to all the great developers who made this possible !!

Feedback welcome :) ... Have fun!


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


