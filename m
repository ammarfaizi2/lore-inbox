Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSFXQyU>; Mon, 24 Jun 2002 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSFXQyT>; Mon, 24 Jun 2002 12:54:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14095 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S314422AbSFXQxx> convert rfc822-to-8bit; Mon, 24 Jun 2002 12:53:53 -0400
Date: Mon, 24 Jun 2002 12:58:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19-rc1
Message-ID: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Directly from OLS you're getting the first release candidate.

Please test it extensively.


Summary of changes from v2.4.19-pre10 to v2.4.19-rc1
============================================

<wim@iguana.be> (02/06/04 1.538)
	[PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 1)

<wim@iguana.be> (02/06/04 1.539)
	[PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 2)

<ctindel@cup.hp.com> (02/06/04 1.537.1.1)
	Bonding driver: Add multicast support.

<alan@lxorguk.ukuu.org.uk> (02/06/04 1.537.2.1)
	[PATCH] PATCH: update urls

<rusty@rustcorp.com.au> (02/06/06 1.537.2.2)
	[PATCH] II ipchains bugs in 2.2_2.4_2.5 related to netlink calls

<rusty@rustcorp.com.au> (02/06/06 1.537.2.3)
	[PATCH] Fix bashisms in scripts_patch-kernel:

<rusty@rustcorp.com.au> (02/06/06 1.537.2.4)
	[PATCH] Re: nbd.c warning fix

<rusty@rustcorp.com.au> (02/06/06 1.537.2.5)
	[PATCH] Typo in radeonfb.c printk()

<rusty@rustcorp.com.au> (02/06/06 1.537.2.6)
	[PATCH] typo in aic7xxx_core.c

<rusty@rustcorp.com.au> (02/06/06 1.537.2.7)
	[PATCH] typo in jazz_esp.c

<rusty@rustcorp.com.au> (02/06/06 1.537.2.8)
	[PATCH] typo in smt.h

<rusty@rustcorp.com.au> (02/06/06 1.537.2.9)
	[PATCH] Remove bogus casts in ide-cd.c

<rusty@rustcorp.com.au> (02/06/06 1.537.2.10)
	[PATCH] Re: mislabelled label patch

<rusty@rustcorp.com.au> (02/06/06 1.537.2.11)
	[PATCH] Finally squish those chrp_start.c warnings

<rusty@rustcorp.com.au> (02/06/06 1.537.2.12)
	[PATCH] TAGS should include arch dir.

<rusty@rustcorp.com.au> (02/06/06 1.537.2.13)
	[PATCH] Fix compilation warning in do_mounts.c (Fixed by Rusty)

<rusty@rustcorp.com.au> (02/06/06 1.537.2.14)
	[PATCH] APM patch for idle_period handling

<rusty@rustcorp.com.au> (02/06/06 1.537.2.15)
	[PATCH] Re: TRIVIAL: William Lee Irwin III: buddy system comment

<rusty@rustcorp.com.au> (02/06/06 1.537.2.16)
	[PATCH] Re: Kernel zombie threads after module removal.

<rusty@rustcorp.com.au> (02/06/06 1.537.2.17)
	[PATCH] fix for sigio delivery

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.18)
	[PATCH] PATCH: url changes

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.19)
	[PATCH] PATCH: more url changes

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.20)
	[PATCH] PATCH: remove dead probe code

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.21)
	[PATCH] PATCH: ramdisk efault fix

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.22)
	[PATCH] PATCH: Fix i830 agp error on 8+8Mb split,

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.23)
	[PATCH] PATCH: switch ftape to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.24)
	[PATCH] PATCH: switch isicom to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.25)
	[PATCH] PATCH: switch specialix to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.26)
	[PATCH] PATCH: switch isdn to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.27)
	[PATCH] PATCH: switch bw-qcam to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.28)
	[PATCH] PATCH: switch pms to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.29)
	[PATCH] PATCH: fix link error in video4linux

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.30)
	[PATCH] PATCH: switch mpt fusion to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.31)
	[PATCH] PATCH: a few more static inlines

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.32)
	[PATCH] PATCH: switch hamradio drivers to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.33)
	[PATCH] PATCH: switch s/390 drivers to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.34)
	[PATCH] PATCH: switch audio to static inline

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.35)
	[PATCH] PATCH: fix wrong __init in neofb

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.36)
	[PATCH] PATCH: Configure.help bits

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.37)
	[PATCH] PATCH; make readv/writev SuS compliant

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.38)
	[PATCH] PATCH: more pci idents we use in kernel now

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.39)
	[PATCH] PATCH: sisfb header I forgot last time

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.40)
	[PATCH] PATCH: barrier didnt go away..

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.41)
	[PATCH] PATCH: rest of SIGURG changes

<alan@lxorguk.ukuu.org.uk> (02/06/06 1.537.2.42)
	[PATCH] PATCH: missing clean

<fdavis@si.rr.com> (02/06/07 1.537.1.2)
	ipconfig.c: Fix defined but not used warnings.

<davem@nuts.ninka.net> (02/06/07 1.537.1.3)
	AF_PACKET: Clear out packet-mmap pages.

<paulus@samba.org> (02/06/07 1.537.2.43)
	[PATCH] icache coherency on cleared pages

<akpm@zip.com.au> (02/06/07 1.537.2.44)
	[PATCH] Remove debug code from /proc/stat

<kaos@ocs.com.au> (02/06/07 1.537.2.45)
	[PATCH] Convert drivers/net/wan/8253x to kernel build

<willy@debian.org> (02/06/07 1.537.2.46)
	[PATCH] Serial driver iomem fixes

<bunk@fs.tum.de> (02/06/07 1.537.2.47)
	[PATCH] disable CONFIG_IEEE1394_PCILYNX_PORTS config option

<willy@debian.org> (02/06/07 1.537.2.48)
	[PATCH] Remove SERIAL_IO_GSC

<davem@nuts.ninka.net> (02/06/10 1.537.1.4)
	tg3.c: Fix typo in GA302T board ID.

<davem@nuts.ninka.net> (02/06/11 1.537.1.5)
	Tigon3: Make fibre PHY support work.

<davem@nuts.ninka.net> (02/06/11 1.537.1.6)
	ip-sysctl.txt fixes

<davem@nuts.ninka.net> (02/06/12 1.537.1.7)
	Tigon3: More fiber PHY tweaks.

<zaitcev@redhat.com> (02/06/12 1.537.2.49)
	[PATCH] Fix s390 partition bug in 2.4.19-pre7

<willy@debian.org> (02/06/12 1.537.2.50)
	[PATCH] Add support for HP Diva serial ports

<felipewd@terra.com.br> (02/06/12 1.537.2.51)
	[PATCH] Re: [PATCH] printk KERN_* in 3c501 driver

<hch@infradead.org> (02/06/12 1.537.2.52)
	[PATCH] don't export walk_gendisk()

<khalid_aziz@hp.com> (02/06/12 1.537.2.53)
	[PATCH] HCDP serial ports

<hch@infradead.org> (02/06/12 1.537.2.54)
	[PATCH] don't export vmalloc_to_page() gplonly

<ajoshi@shell.unixbox.com> (02/06/12 1.537.2.55)
	[PATCH] rivafb fix

<mostrows@watson.ibm.com> (02/06/12 1.537.2.56)
	[PATCH] Documentation Update

<kaos@ocs.com.au> (02/06/12 1.537.2.57)
	[PATCH] 2.4.19-pre10 Enforce uts limit, use LANG=C for date/time

<jani@iv.ro> (02/06/12 1.537.1.9)
	[PATCH] tridentfb update

<kraxel@bytesex.org> (02/06/13 1.537.1.10)
	fix error handling in video_open()

<trini@kernel.crashing.org> (02/06/13 1.537.3.1)
	[PATCH] Fix corner cases of building SA1100/M8xx PCMCIA support

<greg@kroah.com> (02/06/13 1.537.3.2)
	[PATCH] PCI Hotplug ACPI driver minor fix.

<bcrl@redhat.com> (02/06/13 1.537.3.3)
	[PATCH] highmem pci dma mapping does not work, missing cast in asm-i386/pci.h

<bcrl@redhat.com> (02/06/13 1.537.3.4)
	[PATCH] ns83820 v0.18 update

<bcrl@redhat.com> (02/06/13 1.537.3.5)
	[PATCH] misc fixes for 2.4.19-pre10

<trini@kernel.crashing.org> (02/06/13 1.537.3.6)
	[PATCH] Fix compilation of CONFIG_UCODE_PATCH=y

<trini@kernel.crashing.org> (02/06/13 1.537.3.7)
	[PATCH] Fix booting of some machines when loaded into

<ak@muc.de> (02/06/13 1.537.3.8)
	[PATCH] Fix incorrect inline assembly for RAID-5

<hugh@veritas.com> (02/06/13 1.537.3.9)
	[PATCH] tmpfs 1/4 symlink unwind

<hugh@veritas.com> (02/06/13 1.537.3.10)
	[PATCH] tmpfs 2/4 mknod times

<hugh@veritas.com> (02/06/13 1.537.3.11)
	[PATCH] tmpfs 3/4 partial truncate

<hugh@veritas.com> (02/06/13 1.537.3.12)
	[PATCH] tmpfs 4/4 swapoff tweaks

<hugh@veritas.com> (02/06/13 1.537.3.13)
	[PATCH] swap 1/4 swapon memleak

<hugh@veritas.com> (02/06/13 1.537.3.14)
	[PATCH] swap 2/4 unsafe SwapCache check

<hugh@veritas.com> (02/06/13 1.537.3.15)
	[PATCH] swap 3/4 unsafe Dirty check

<hugh@veritas.com> (02/06/13 1.537.3.16)
	[PATCH] swap 4/4 redundant SwapCache checks

<dok@directfb.org> (02/06/13 1.537.3.17)
	[PATCH] CyberPro 32bit support and other fixes

<hch@infradead.org> (02/06/13 1.537.3.18)
	[PATCH] add missing 2.5 compatible kdev_t bits

<nkbj@image.dk> (02/06/17 1.537.1.12)
	[PATCH] Update for arch/i386/defconfig

<kai@tp1.ruhr-uni-bochum.de> (02/06/18 1.537.1.13)
	ISDN: Fix oops when unloading drivers in non LIFO order

<rbt@mtlb.co.uk> (02/06/18 1.537.1.14)
	[PATCH] Trivial, IDE geometry fix / defconfig changes

<snailtalk@linux-mandrake.com> (02/06/18 1.537.4.1)
	Add includes necessary for Alpha AXP platform, to these drivers:

<snailtalk@linux-mandrake.com> (02/06/18 1.537.4.2)
	Fix spinlock goof in w83877f watchdog driver

<jgarzik@mandrakesoft.com> (02/06/19 1.537.5.1)
	Update 8139 net drivers for the following fixes:

<jgarzik@mandrakesoft.com> (02/06/20 1.537.4.3)
	Reserve 2.5.x extended attribute syscall numbers, for alpha port.

<wim@iguana.be> (02/06/22 1.537.6.1)
	[PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 3)

<wim@iguana.be> (02/06/22 1.537.6.2)
	[PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 4)

<wim@iguana.be> (02/06/22 1.537.7.1)
	[PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 5)

<ak@muc.de> (02/06/24 1.541)
	[PATCH] Another fix for the RAID-5 inline assembly

<adam@nmt.edu> (02/06/24 1.545)
	[PATCH] 3ware driver update for 2.4

<ak@muc.de> (02/06/24 1.547)
	[PATCH] Make panic blink configurable

<mikpe@csd.uu.se> (02/06/24 1.548)
	[PATCH] fs/ufs/super.c:ufs_read_super() fixes

<bunk@fs.tum.de> (02/06/24 1.549)
	[PATCH] fix .text.exit compile error in sstfb.c

<richard.brunner@amd.com> (02/06/24 1.550)
	[PATCH] Fix cache-attribute conflict bug on newer AMD Athlon

<marcelo@plucky.distro.conectiva> (02/06/24 1.552)
	Makefile:

Summary of changes from v2.4.19-pre9 to v2.4.19-pre10
============================================

<jgarzik@mandrakesoft.com> (02/05/03 1.404.1.1)
	Add new "comet" pci id to tulip net driver.

<ivangurdiev@linuxfreemail.com> (02/05/03 1.404.1.2)
	Minor fixes to the via-rhine net driver:

<davem@nuts.ninka.net> (02/05/05 1.383.17.10)
	net/core/neighbour.c: Delete ancient ASSERT_WL debugging.

<jmorris@intercode.com.au> (02/05/05 1.383.17.11)
	Tigon3: Handle Netgear GA302T correctly.

<laforge@gnumonks.org> (02/05/07 1.404.3.1)
	Netfilter ipt_ULOG fix:

<grundler@cup.hp.com> (02/05/07 1.404.3.3)
	Tigon3 fix:

<robert.olsson@data.slu.se> (02/05/09 1.404.3.4)
	IPV4: Add statistics for route cache GC monitoring.

<davem@nuts.ninka.net> (02/05/10 1.404.3.5)
	tcp_ipv4.c: Do not increment TcpAttemptFails twice.

<davem@nuts.ninka.net> (02/05/10 1.404.3.6)
	Ingress packet scheduler: Fix compiler error when CONFIG_NET_CLS_POLICE is disabled.

<hch@infradead.org> (02/05/10 1.404.3.7)
	IPv4 Syncookies: Remove pointless CONFIG_SYN_COOKIES ifdef.

<quintela@mandrakesoft.com> (02/05/11 1.404.1.3)
	tulip net driver 2114x phy init fix

<jdavid@farfalle.com> (02/05/11 1.404.1.4)
	Add full duplex support to 3c509 net driver.

<skyrelighten@yahoo.co.kr> (02/05/11 1.404.1.5)
	Add to list of supported 8139 net boards.

<os@emlix.com> (02/05/11 1.404.1.6)
	cs89x0 net driver minor fixes, SH4 support, and cmd line media support

<kasperd@daimi.au.dk> (02/05/11 1.404.1.7)
	Fix oops-able situation in 3c509 net driver

<wstinson@infonie.fr> (02/05/11 1.404.4.2)
	request_region janitor cleanup for rtc char driver

<davem@nuts.ninka.net> (02/05/13 1.404.3.8)
	IPv4: Make pkt_too_big debug msg more informative.

<rl@hellgate.ch> (02/05/16 1.445.1.2)
	Cosmetic cleanups, remove unused struct members from via-rhine net driver

<jgarzik@mandrakesoft.com> (02/05/16 1.445.1.3)
	Update mii generic phy driver to properly report link status.

<jgarzik@mandrakesoft.com> (02/05/16 1.445.1.4)
	Fix phy id masking in 8139too net driver.

<pazke@orbita1.ru> (02/05/16 1.445.1.5)
	Janitor: add __devinit markers to two net drivers, epic100 and sundance

<kuznet@ms2.inr.ac.ru> (02/05/16 1.404.3.9)
	tcp_input.c: Really make sure rto = 3*rtt, found by Pasi Sarolahti

<simonb@lipsyncpost.co.uk> (02/05/20 1.404.3.10)
	Tigon3: Add Netgear GA320T support.

<davem@nuts.ninka.net> (02/05/20 1.404.3.11)
	Tigon3: Fix typo in netgear ga320t support changes.

<ccaputo@alt.net> (02/05/21 1.404.3.12)
	net/core/sock.c: Fix typo in sysctl_{w,m}mem_default init.

<kuznet@ms2.inr.ac.ru> (02/05/21 1.404.3.13)
	tcp_recvmsg: Fix application bug induced races with MSG_PEEK and copied_seq.

<kuznet@ms2.inr.ac.ru> (02/05/23 1.404.3.14)
	net/sched fixes:

<kuznet@ms2.inr.ac.ru> (02/05/23 1.404.3.15)
	ipv6 raw fixes:

<alan@lxorguk.ukuu.org.uk> (02/05/29 1.445.2.38)
	[PATCH] PATCH: doc typos

<davem@nuts.ninka.net> (02/05/29 1.383.11.40)
	Update Sparc{,64} ide_fix_driveid.

<jgarzik@mandrakesoft.com> (02/05/30 1.445.1.7)
	Merge 2.5.x additions to linux/ethtool.h.

<andersg@0x63.nu> (02/05/30 1.445.1.8)
	Renames struct bus_type to struct de4x5_bus_type in de4x5 net driver,

<maalanen@ra.abo.fi> (02/05/30 1.445.1.9)
	request_region janitor cleanup for pcnet32 net driver,

<go@turbolinux.co.jp> (02/05/30 1.445.1.10)
	Fix pcnet32 net driver workaround for xSeries250.

<pavel@ucw.cz> (02/05/30 1.445.1.11)
	eepro100 net driver trivial cleanup:

<edward_peng@dlink.com.tw> (02/05/30 1.445.1.12)
	dl2k gige net driver update:

<rusty@rustcorp.com.au> (02/06/03 1.451)
	[PATCH] Trivial 2.4.19-pre9: asm/io.h in mm/bootmem.c

<rusty@rustcorp.com.au> (02/06/03 1.452)
	[PATCH] Trivial 2.4.19-pre9: ipchains compat kmalloc flags

<rusty@rustcorp.com.au> (02/06/03 1.453)
	[PATCH] Trivial 2.4.19-pre9: typo in fs/dcache.c

<rusty@rustcorp.com.au> (02/06/03 1.454)
	[PATCH] Trivial 2.4.19-pre9: SUSv2 semctl compliance:

<rusty@rustcorp.com.au> (02/06/03 1.455)
	[PATCH] Trivial 2.4.19-pre9: drivers/net/pcnet32.c

<rusty@rustcorp.com.au> (02/06/03 1.456)
	[PATCH] Trivial 2.4.19-pre9: binfmt_misc setbit bug

<rusty@rustcorp.com.au> (02/06/03 1.457)
	[PATCH] Trivial 2.4.19-pre9: CREDITS ordering

<rusty@rustcorp.com.au> (02/06/03 1.458)
	[PATCH] Trivial 2.4.19-pre9: DMA documentation fix

<rusty@rustcorp.com.au> (02/06/03 1.459)
	[PATCH] Trivial 2.4.19-pre9: header comment fix

<rusty@rustcorp.com.au> (02/06/03 1.460)
	[PATCH] Trivial 2.4.19-pre9: check_region from

<rusty@rustcorp.com.au> (02/06/03 1.461)
	[PATCH] Trivial 2.4.19-pre9: check_region in drivers/atm/horizon.c

<rusty@rustcorp.com.au> (02/06/03 1.462)
	[PATCH] Trivial 2.4.19-pre9: check_region in paride

<rusty@rustcorp.com.au> (02/06/03 1.463)
	[PATCH] Trivial 2.4.19-pre9: normalize slab names

<rusty@rustcorp.com.au> (02/06/03 1.464)
	[PATCH] Trivial but vitally important patch.

<kaos@ocs.com.au> (02/06/03 1.465)
	[PATCH] 2.4.19-pre9 USB Makefile

<gtoumi@laposte.net> (02/06/03 1.466)
	[PATCH] sstfb update : P0-Revert

<gtoumi@laposte.net> (02/06/03 1.467)
	[PATCH] sstfb update : P1-Alpha

<gtoumi@laposte.net> (02/06/03 1.468)
	[PATCH] sstfb update : P2-pci

<gtoumi@laposte.net> (02/06/03 1.469)
	[PATCH] sstfb update : P3-indent

<gtoumi@laposte.net> (02/06/03 1.470)
	[PATCH] sstfb update : P4-fbinfo

<gtoumi@laposte.net> (02/06/03 1.471)
	[PATCH] sstfb update : P5-Multihead

<gtoumi@laposte.net> (02/06/03 1.472)
	[PATCH] sstfb update : P6-VidMod

<gtoumi@laposte.net> (02/06/03 1.473)
	[PATCH] sstfb update : P7-misc

<gtoumi@laposte.net> (02/06/03 1.474)
	[PATCH] sstfb update : P8-checks

<jhammer@us.ibm.com> (02/06/03 1.475)
	[PATCH] ips 4.90.18 build fix

<dmccr@us.ibm.com> (02/06/03 1.476)
	[PATCH] Thread group exit problem reappeared.

<benh@kernel.crashing.org> (02/06/03 1.477)
	[PATCH] PPC: Add support for 750FX CPU

<benh@kernel.crashing.org> (02/06/03 1.478)
	[PATCH] PPC: Fix /proc/irq duplicate entries

<benh@kernel.crashing.org> (02/06/03 1.479)
	[PATCH] PPC: Pmac support update

<benh@kernel.crashing.org> (02/06/03 1.480)
	[PATCH] PPC: Fix warning

<benh@kernel.crashing.org> (02/06/03 1.481)
	[PATCH] PPC: Fix dmasound with KDE

<quintela@mandrakesoft.com> (02/06/03 1.483)
	[PATCH] : kernel-api.* compilation fix

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.484)
	[PATCH] PATCH: Handle old Dec boxes with misconfigured scsi

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.485)
	[PATCH] PATCH: Fix SIGURG strict standards compliance

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.486)
	[PATCH] PATCH:Fix a misuse of copy_from_user

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.487)
	[PATCH] PATCH: copy_user fix for S/390

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.488)
	[PATCH] PATCH: second copy_user fix for S/390

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.489)
	[PATCH] PATCH: copy_user fixes for s390x

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.490)
	[PATCH] PATCH: clean up copy_user in paride, and unused var

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.491)
	[PATCH] PATCH: fix copy_user in swim3

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.492)
	[PATCH] PATCH: fix copy_user in macIIfx floppies

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.493)
	[PATCH] PATCH: fixup illegal C in umem

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.494)
	[PATCH] PATCH; serial copy_user fixes

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.495)
	[PATCH] PATCH: machz watchdog copy_user fixes

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.496)
	[PATCH] PATCH: mxser copy_user fixes

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.497)
	[PATCH] PATCH: fix sigio on tty drivers outgoing

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.498)
	[PATCH] PATCH: enable the tty sigio fix on pty

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.499)
	[PATCH] PATCH: resync pcwd with 2.5 fixes

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.500)
	[PATCH] PATCH: fix stallion and sx copy_user

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.501)
	[PATCH] PATCH:hotplug requires pci

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.502)
	[PATCH] PATCH: fix tpqic02 copy_user

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.503)
	[PATCH] PATCH: fix backward copies in joydev.

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.504)
	[PATCH] PATCH:acenic new card

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.505)
	[PATCH] PATCH: iph5526 fix from maintainer

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.506)
	[PATCH] PATCH: delete all the usercrap that accidentally got in

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.507)
	[PATCH] PATCH: sdla_fr nipquad fixes

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.508)
	[PATCH] PATCH: web page moved

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.509)
	[PATCH] PATCH: maintainer updated for aha152x

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.510)
	[PATCH] PATCH: qlogic panic fix

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.511)
	[PATCH] PATCH: scsi copy_user fixes

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.512)
	[PATCH] PATCH; blacklist update

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.513)
	[PATCH] PATCH: fix possible leak of kernel data

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.514)
	[PATCH] PATCH: sgi serial fix for copy_user

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.515)
	[PATCH] PATCH: add $CONFIG_PCI and fix sound texts

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.516)
	[PATCH] PATCH: more ac97 updates

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.517)
	[PATCH] PATCH: fix isapnp ad1848

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.518)
	[PATCH] PATCH: more copy_user

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.519)
	[PATCH] PATCH: add intel ICH4

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.520)
	[PATCH] PATCH: and more copy_user (blame acme and rusty)

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.521)
	[PATCH] PATCH: mpu401 clean and leak fix

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.522)
	[PATCH] PATCH: fix region leak

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.523)
	[PATCH] PATCH: yet another SB

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.524)
	[PATCH] PATCH: fix ali crash on 6 channel capable chip with cheap codec

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.525)
	[PATCH] PATCH: more copy_user

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.526)
	[PATCH] PATCH: make this defined C

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.527)
	[PATCH] PATCH: intermezzo copy_user

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.528)
	[PATCH] PATCH: mapping fix

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.529)
	[PATCH] PATCH: take signal lock before looking at signals in proc

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.530)
	[PATCH] PATCH: better fix for fs/ufs - add printk levels

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.531)
	[PATCH] PATCH sisfb updates - been in -ac for ages

<alan@lxorguk.ukuu.org.uk> (02/06/03 1.532)
	[PATCH] PATCH: mkspec improvements

<jaharkes@cs.cmu.edu> (02/06/03 1.533)
	[PATCH] 2.4.19-pre9  Coda update

<jgarzik@mandrakesoft.com> (02/06/03 1.534)
	[PATCH] PATCH: revert 3c59x

<marcelo@plucky.distro.conectiva> (02/06/03 1.535)
	Remove change which could break userlevel apps

<bcrl@redhat.com> (02/06/03 1.536)
	[PATCH] /proc/slab fix

<marcelo@plucky.distro.conectiva> (02/06/03 1.537)
	Changed EXTRAVERSION to pre10

Summary of changes from v2.4.19-pre8 to v2.4.19-pre9
============================================

<david-b@pacbell.net> (02/05/02 1.383.20.1)
	[PATCH] PATCH 2.4.19-pre7 usb-ohci and wmb()

<david-b@pacbell.net> (02/05/02 1.383.20.2)
	[PATCH] PATCH 2.4.19-pre7 sync ehci-hcd with 2.5

<david-b@pacbell.net> (02/05/02 1.383.20.3)
	[PATCH] PATCH 2.4.19-pre7 sync ehci.txt

<ganesh@veritas.com> (02/05/03 1.406)
	[PATCH] adds support for USB Casio EM500

<wolfgang.fritz@gmx.net> (02/05/03 1.407)
	[PATCH] pl2303.c: do not reset termios settings in each open()

<greg@kroah.com> (02/05/03 1.408)
	USB io_edgeport driver

<vojtech@suse.cz> (02/05/03 1.409)
	[PATCH] HID blacklist update

<oliver@oenone.homelinux.org> (02/05/03 1.410)
	[PATCH] devfs race fix

<s.doyon@videotron.ca> (02/05/03 1.411)
	[PATCH] add Tieman Voyager USB Braille display driver

<oliver@oenone.homelinux.org> (02/05/03 1.412)
	[PATCH] USB host TASK_RUNNING fix

<petkan@mastika.lnxw.com> (02/05/03 1.413)
	[PATCH] pegasus driver update

<davem@nuts.ninka.net> (02/05/03 1.383.17.9)
	in_ntoa: Did not kill off all references properly.

<davem@nuts.ninka.net> (02/05/03 1.383.11.17)
	arch/sparc64/defconfig: Update.

<davem@nuts.ninka.net> (02/05/03 1.383.11.18)
	arch/sparc/kernel/check_asm.sh:

<davem@nuts.ninka.net> (02/05/03 1.383.11.19)
	arch/sparc/kernel/check_asm.sh: Fix typo.

<rob@osinvestor.com> (02/05/04 1.383.11.20)
	Sparc32 sun4c:

<davem@nuts.ninka.net> (02/05/04 1.383.11.21)
	arch/sparc/defconfig: Update.

<david-b@pacbell.net> (02/05/06 1.414)
	[PATCH] PATCH ehci -- interrupt xfer requeue

<davem@nuts.ninka.net> (02/05/06 1.383.11.22)
	soft-fp fix:

<mikpe@csd.uu.se> (02/05/06 1.404.2.1)
	[PATCH] fix 2.4.19-pre8 UP APIC breakage

<hch@infradead.org> (02/05/06 1.404.2.2)
	[PATCH] memsetup fixes (again)

<viro@math.psu.edu> (02/05/06 1.404.2.3)
	[PATCH] ufs/super.c fix

<bunk@fs.tum.de> (02/05/06 1.404.2.5)
	[PATCH] give better information which chipsets hpt366.c is for

<marcelo@conectiva.com.br> (02/05/06 1.404.2.6)
	[PATCH] Apply missing hunk of hpt366 patch

<bunk@fs.tum.de> (02/05/06 1.404.2.7)
	[PATCH] CONFIG_AGP_HP_ZX1 should only be available on ia64

<viro@math.psu.edu> (02/05/06 1.404.2.8)
	[PATCH] change_floppy(): O_NDELAY is needed when opening floppy for FD_EJECT

<jaharkes@cs.cmu.edu> (02/05/06 1.404.2.9)
	[PATCH] 2.4.19-pre8  Coda update

<neilb@cse.unsw.edu.au> (02/05/06 1.404.2.10)
	[PATCH] Fix umem compile problems

<david-b@pacbell.net> (02/05/07 1.415)
	[PATCH] PATCH 2.5.14 -- ehci misc fixes

<colin@gibbs.dhs.org> (02/05/07 1.383.11.23)
	copy_mm fix:

<davem@nuts.ninka.net> (02/05/07 1.383.11.24)
	Sparc64 fix:

<davem@nuts.ninka.net> (02/05/08 1.383.11.25)
	Soft-fp fix:

<wayne@stallion.oz.au> (02/05/09 1.404.2.11)
	[PATCH] drivers/char/stallion.c

<davem@nuts.ninka.net> (02/05/08 1.383.11.26)
	Sparc64: Make use of USE_STANDARD_AS_RULE.

<jgarzik@mandrakesoft.com> (02/05/09 1.404.4.1)
	Add two new AC97 codec ids to ac97_codec driver.

<tcallawa@redhat.com> (02/05/09 1.383.11.27)
	Sparc: Use proper sys_{read,write} prototypes in SunOS

<tcallawa@redhat.com> (02/05/09 1.383.11.28)
	Sparc64: Export batten_down_hatches

<tcallawa@redhat.com> (02/05/09 1.383.11.29)
	drivers/video/aty/mach64_gx.c: Include sched.h

<tcallawa@redhat.com> (02/05/09 1.383.11.30)
	Sparc64: Put sys_tkill in correct systable slots.

<davem@nuts.ninka.net> (02/05/09 1.383.11.31)
	Sparc64 fixes:

<kkeil@isdn4linux.de> (02/05/09 1.404.5.1)
	ISDN: Add PPP statistics in bytes

<davem@nuts.ninka.net> (02/05/10 1.383.11.32)
	Sparc: Fix unistd.h __NR_tkill numbers.

<davem@nuts.ninka.net> (02/05/10 1.383.11.33)
	Sparc64: Missed parts of math-emu fixes.

<davem@nuts.ninka.net> (02/05/10 1.383.11.34)
	Sparc fixes:

<davem@nuts.ninka.net> (02/05/10 1.383.11.35)
	Sparc: Use dma_addr_t and size_t in sparc32 DMA function args.

<davem@nuts.ninka.net> (02/05/10 1.383.11.36)
	Sparc: More sparc32 dma_addr_t fixups.

<dwmw2@dwmw2.baythorne.internal> (02/05/12 1.404.6.1)
	JFFS2 update - fix double free in garbage-collecting hole nodes.

<kai@tp1.ruhr-uni-bochum.de> (02/05/13 1.404.7.1)
	ISDN: Export all hisax symbols from drivers/isdn/hisax/config.o

<colin@gibbs.dhs.org> (02/05/13 1.383.11.37)
	Sparc: Do not BUG in srmmu_pte_alloc_one.

<colin@gibbs.dhs.org> (02/05/13 1.383.11.38)
	include/asm-sparc/pgalloc.h: In pmd_alloc_one, dont BUG just return NULL

<davem@nuts.ninka.net> (02/05/13 1.383.11.39)
	drivers/net/sunlance.c: Make init_block_dvma a dma_addr_t

<ak@muc.de> (02/05/13 1.417)
	[PATCH] Fix panic for gcc 3.1

<ak@muc.de> (02/05/13 1.418)
	[PATCH] long -> unsigned long flags for softirq

<rob@osinvestor.com> (02/05/13 1.419)
	[PATCH] drivers/char/sc1200wdt.c

<rwhron@earthlink.net> (02/05/13 1.420)
	[PATCH] Fix ips driver breakage on 2.4.19-pre8

<hch@infradead.org> (02/05/13 1.421)
	[PATCH] fix compile warning in ini/do_mount.c

<hch@infradead.org> (02/05/13 1.422)
	[PATCH] cleanup/remove memlist wrappers

<gibbs@scsiguy.com> (02/05/13 1.423)
	Here's another aic7xxx driver update.  This corrects the following

<kaos@ocs.com.au> (02/05/13 1.424)
	[PATCH] 2.4.19-pre8 config bug fixes

<jani@iv.ro> (02/05/13 1.425)
	[PATCH] tridentfb update

<benh@kernel.crashing.org> (02/05/13 1.426)
	[PATCH] PPC 745x CPU updates

<benh@kernel.crashing.org> (02/05/13 1.427)
	[PATCH] PPC Small PCI fixes

<benh@kernel.crashing.org> (02/05/13 1.428)
	[PATCH] PPC PowerMac PCI fix

<benh@kernel.crashing.org> (02/05/13 1.429)
	[PATCH] PPC Missing pci_ids

<benh@kernel.crashing.org> (02/05/13 1.430)
	[PATCH] Add walk_gendisk

<benh@kernel.crashing.org> (02/05/13 1.431)
	[PATCH] PPC Updated Pmac root discovery

<benh@kernel.crashing.org> (02/05/13 1.432)
	[PATCH] PPC Updated MESH driver

<benh@kernel.crashing.org> (02/05/13 1.433)
	[PATCH] PPC planb driver update

<mikpe@csd.uu.se> (02/05/13 1.434)
	[PATCH] 2.4.19-pre7+ I/O-APIC inconsistency

<neilb@cse.unsw.edu.au> (02/05/13 1.435)
	[PATCH] PATCH - kNFSd in 2.4.19-pre8 - small nfssvc.c changes

<szepe@pinerecords.com> (02/05/13 1.436)
	[PATCH] 2.4.18, add missing MODULE_LICENSE tags in fs/

<hch@infradead.org> (02/05/13 1.437)
	[PATCH] fix gcc 3.1 compiler warnings in asm-i386/floppy.h

<hch@infradead.org> (02/05/13 1.438)
	[PATCH] remove compile warning in drivers/pnp/isapnp.c

<hch@infradead.org> (02/05/13 1.439)
	[PATCH] fix gcc 3.1 warnings in bfs

<hch@infradead.org> (02/05/14 1.440)
	[PATCH] fix gcc 3.1 warnings in drivers/i2c/i2c-core.c

<hch@infradead.org> (02/05/14 1.441)
	[PATCH] gcc 3.1 fixes for fs/file.c

<hch@infradead.org> (02/05/14 1.442)
	[PATCH] gcc 3.1 fixes for drivers/block/ll_rw_blk.c

<jhartmann@addoes.com> (02/05/14 1.444)
	[PATCH] Add I845G support to agpgart

<mlindner@syskonnect.de> (02/05/14 1.445)
	[PATCH] SysKonnect FDDI driver bugfixes

<rgooch@atnf.csiro.au> (02/05/14 1.445.2.1)
	Added BKL to <devfs_open> because drivers still need it.

<viro@math.psu.edu> (02/05/15 1.445.3.1)
	[PATCH] do_mounts.c printk fix

<hch@infradead.org> (02/05/15 1.445.3.2)
	[PATCH] remove noisy printk in fs/block_device.c

<rbh00@utsglobal.com> (02/05/15 1.445.3.3)
	[PATCH] 3270-console reboot bug fixed

<olh@suse.de> (02/05/15 1.445.3.4)
	[PATCH] 2.4.19-pre8  drivers/scsi/scsi_debug.c

<sfr@canb.auug.org.au> (02/05/15 1.445.3.5)
	[PATCH] Directory Notification Fix

<bcrl@redhat.com> (02/05/15 1.445.3.6)
	[PATCH] fix for /proc/stat

<anton@samba.org> (02/05/15 1.445.3.7)
	[PATCH] Fix acenic driver and 867 MHz G4 sound problems

<gibbs@overdrive.btc.adaptec.com> (02/05/16 1.445.3.8)
	Upgrade to v6.2.8 of the aic7xxx driver

<hch@infradead.org> (02/05/20 1.445.2.4)
	[PATCH] ClearPageLaunder instead of opencoded bitops

<pkot@ziew.org> (02/05/20 1.445.2.6)
	[PATCH] Move MAX_BUF_PER_PAGE definition into the header file

<ldb@ldb.ods.org> (02/05/20 1.445.2.7)
	[PATCH] Fix PPPoATM crash on disconnection

<kai@tp1.ruhr-uni-bochum.de> (02/05/21 1.445.2.9)
	ISDN: Update md5sums

<paulus@samba.org> (02/05/21 1.445.2.10)
	[PATCH] important PPC bugfix for 2.4.19-pre

<hugh@veritas.com> (02/05/21 1.445.2.11)
	[PATCH] "noht" disable HyperThreading

<macro@ds2.pg.gda.pl> (02/05/21 1.445.2.12)
	[PATCH] linux 2.4.19-pre8: Critical signal handling fixes

<Martin.Bligh@us.ibm.com> (02/05/21 1.445.2.13)
	[PATCH] remove spurious timer interrupts

<rusty@rustcorp.com.au> (02/05/21 1.445.2.14)
	[PATCH] Trivial declance updates

<sfr@canb.auug.org.au> (02/05/21 1.445.2.15)
	[PATCH] PATCH] 2.4.19-pre8 small typo in signal code for cris

<rusty@rustcorp.com.au> (02/05/21 1.445.2.16)
	[PATCH] epic100 missing __devinit

<rusty@rustcorp.com.au> (02/05/21 1.445.2.17)
	[PATCH] sundance missing __devinit

<rusty@rustcorp.com.au> (02/05/21 1.445.2.18)
	[PATCH] TRIVIAL serial unload message

<gibbs@overdrive.btc.adaptec.com> (02/05/22 1.445.3.9)
	6.2.8

<jbglaw@lug-owl.de> (02/05/22 1.445.4.1)
	[PATCH] Update to srm_env.c update (for Alpha arch.)

<gibbs@overdrive.btc.adaptec.com> (02/05/22 1.445.2.20)
	Last minute changes for the 6.2.8 driver release.

<torvalds@transmeta.com> (02/05/22 1.445.4.2)
	[PATCH] Fix small fsuid consistency issue

<hch@infradead.org> (02/05/23 1.445.4.3)
	[PATCH] fix ad1816 isapnp handling

<rob@osinvestor.com> (02/05/23 1.445.4.4)
	[PATCH] drivers/char/advantechwdt.c

<neilb@cse.unsw.edu.au> (02/05/23 1.445.4.5)
	[PATCH] PATCH - md in 2.4.19-pre - Correctly abort recovery if raid

<kaos@ocs.com.au> (02/05/23 1.445.4.6)
	[PATCH] 2.4.19-pre8 correct build of m8xx_pcmcia

<kaos@ocs.com.au> (02/05/23 1.445.4.7)
	[PATCH] 2.4.19-pre8 remove duplicate CONFIG_SOUND_EMU10K1

<michal@harddata.com> (02/05/23 1.445.4.8)
	[PATCH] Compilation trouble in drivers/video

<mcp@linux-systeme.de> (02/05/23 1.445.4.9)
	[PATCH] 2.4.19-pre8 Intermezzo Compile Fix

<jani@astechnix.ro> (02/05/23 1.445.4.10)
	[PATCH] tridentfb doc update

<scott_anderson@mvista.com> (02/05/23 1.445.4.11)
	[PATCH] PATCH: Fix for typo for NeoMagic in drivers/video/Config.in

<plars@austin.ibm.com> (02/05/23 1.445.4.12)
	[PATCH] 2.4.19-pre8 get_pid() hang fix again

<EdV@macrolink.com> (02/05/23 1.445.4.13)
	[PATCH] OXSEMI 16PCI952 patch

<rgooch@atnf.csiro.au> (02/05/24 1.445.5.1)
	generic.h:

<alan@lxorguk.ukuu.org.uk> (02/05/24 1.445.2.22)
	[PATCH] PATCH: doc thinko

<alan@lxorguk.ukuu.org.uk> (02/05/24 1.445.2.23)
	[PATCH] PATCH: wrong URL

<alan@lxorguk.ukuu.org.uk> (02/05/24 1.445.2.24)
	[PATCH] PATCH: I2O update first part

<rgooch@atnf.csiro.au> (02/05/26 1.445.5.2)
	types.h:

<hch@infradead.org> (02/05/27 1.445.2.25)
	[PATCH] remove unused variable in fs/proc/proc_misc.c

<rhw@InfraDead.Org> (02/05/27 1.445.2.26)
	[PATCH] Minor patch to 2.4 kernel

<alan@lxorguk.ukuu.org.uk> (02/05/28 1.445.2.28)
	[PATCH] PATCH: I2O update

<marcelo@plucky.distro.conectiva> (02/05/28 1.445.2.29)
	Add missing i2o patch part

<marcelo@plucky.distro.conectiva> (02/05/28 1.445.2.30)
	Added missing "#" to ifdef

<rhirst@linuxcare.com> (02/05/28 1.445.2.31)
	[PATCH] PATCH 2.4.19-pre8: drivers/scsi/sim710

<marcelo@plucky.distro.conectiva> (02/05/28 1.445.2.32)
	add missing include file

<rui.sousa@laposte.net> (02/05/28 1.445.2.33)
	[PATCH] Emu10k1 patch for 2.4.19pre8

<jbglaw@lug-owl.de> (02/05/28 1.445.2.34)
	[PATCH] alpha_using_srm (and calback) cleanup

<bjorn.wesen@axis.com> (02/05/28 1.445.2.35)
	[PATCH] arch/cris for 2.4.19-pre8

<ghoz@sympatico.ca> (02/05/28 1.445.2.36)
	[PATCH] mucho trivial update to pci/quirks.c

<marcelo@plucky.distro.conectiva> (02/05/28 1.445.2.37)
	Changed EXTRAVERSION to pre9

Summary of changes from v2.4.19-pre7 to v2.4.19-pre8
============================================

<arjanv@redhat.com> (02/04/04 1.220.5.2)
	Merge some new PCI IDs from 2.5.x e100 to eepro100 net driver.

<akpm@zip.com.au> (02/04/04 1.220.5.3)
	Various minor bug fixes for the 3c59x net driver.

<k.kasprzak@box43.pl> (02/04/05 1.385)
	dgrs net driver janitor fixes:

<santiago@newphoenix.net> (02/04/05 1.383.1.1)
	Update OSS ac97_codec driver to add special init and control

<davej@suse.de> (02/04/05 1.386)
	Cosmetic cleanups to 8139cp net driver.

<zwane@commfireservices.com> (02/04/05 1.387)
	Add power management support to 3c509 net driver.

<kraxel@bytesex.org> (02/04/15 1.383.10.1)
	backport 2.5.8 videodev fixes

<kraxel@bytesex.org> (02/04/15 1.383.10.2)
	adapt meye driver to videodev fixes

<wim@iguana.be> (02/04/16 1.383.2.35)
	Merged in Matt Domsch nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT from the 2.5 kernel.

<stelian@popies.net> (02/04/17 1.383.11.1)
	Doclet for sonypi driver, as reported by Christoph Begall.

<stelian@popies.net> (02/04/17 1.383.11.2)
	fix an off by one bug in command line parameter parsing

<stelian@popies.net> (02/04/17 1.383.12.1)
	Fix meye driver request_irq bug.

<stelian@popies.net> (02/04/17 1.383.12.2)
	Enable the meye driver to get parameters on the kernel command line.

<akpm@zip.com.au> (02/04/17 1.383.13.1)
	[PATCH] add __LINE__ to out_of_line_bug()

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.2)
	[PATCH] PATCH: some configure.help updates

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.3)
	[PATCH] PATCH: more configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.4)
	[PATCH] PATCH: More configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.5)
	[PATCH] PATCH: more Configure.help

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.6)
	[PATCH] PATCH: maintainers update

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.7)
	[PATCH] PATCH: make cpu names clearer for new VIA

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.8)
	[PATCH] PATCH: dmi now handles boxes where apic enabling is bad

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.9)
	[PATCH] PATCH: via fix updates

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.10)
	[PATCH] PATCH: turn on ACPI SMP scan for hypedthreading

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.11)
	[PATCH] PATCH: optimisation - align the tlbstate

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.12)
	[PATCH] PATCH: shift apic mapping init and only if apic desired

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.13)
	[PATCH] PATCH: fix kernel memcpy prefetch

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.14)
	[PATCH] PATCH: newer mpt fusio works on ia64

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.15)
	[PATCH] PATCH: kernel printk levels for ia64 init

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.16)
	[PATCH] PATCH: kernel printk levels for mips32/mips64

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.17)
	[PATCH] PATCH: fix up printk levels for ppc

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.18)
	[PATCH] PATCH: fix s/390 cross compile

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.19)
	[PATCH] PATCH: second s/390 cross compile fix + printk levels

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.20)
	[PATCH] PATCH: printk levels for s390 64bit

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.21)
	[PATCH] PATCH: sparc printk levels

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.22)
	[PATCH] PATCH: printk levels for sh

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.23)
	[PATCH] PATCH: fix up some paride porting bits

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.24)
	[PATCH] PATCH: allow root to use sysctl to set the rtc limit

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.25)
	[PATCH] PATCH: add support for the earliest specialix sx variants

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.26)
	[PATCH] PATCH: (reminder) sak..

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.27)
	[PATCH] PATCH: fix smp watchdog build

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.28)
	[PATCH] PATCH: add byte counts to mkiss

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.29)
	[PATCH] PATCH: add mobility electronics parport

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.30)
	[PATCH] PATCH: fix pcmcia config properly

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.31)
	[PATCH] PATCH: fix region handling in isapnp

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.32)
	[PATCH] PATCH: Add aurora/telford tools wan drivers

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.33)
	[PATCH] PATCH: further osund copyfromuser bits

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.34)
	[PATCH] PATCH: some codec init updates

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.35)
	[PATCH] PATCH: minimal fixes for the emu10k crash with highmem bug

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.36)
	[PATCH] PATCH: handle setup_arg_pages fail

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.37)
	[PATCH] PATCH: printk levels for dcache

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.38)
	[PATCH] PATCH: inode.c printk

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.39)
	[PATCH] PATCH: fix unicode mishandling

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.40)
	[PATCH] PATCH: add prototypes for apic timer handling functions

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.41)
	[PATCH] PATCH: fix NLS unpack for UTF8

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.42)
	[PATCH] PATCH: more PCI idents

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.43)
	[PATCH] PATCH: missing tr_source_route prototype

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.44)
	[PATCH] PATCH: expose tr_source_route

<alan@lxorguk.ukuu.org.uk> (02/04/17 1.383.13.45)
	[PATCH] PATCH: save .config for rpm

<bcrl@redhat.com> (02/04/17 1.383.13.46)
	[PATCH] Fix /proc/slabinfo memory overflow

<tim@physik3.uni-rostock.de> (02/04/17 1.383.13.47)
	[PATCH] fix up incorrect jiffies compare fix

<khalid@fc.hp.com> (02/04/18 1.383.13.50)
	[PATCH] serial ports moved on i386 in 2.4.19-pre7

<tigran@aivazian.name> (02/04/18 1.383.13.51)
	[PATCH] fix compiler warning in microcode driver

<trond.myklebust@fys.uio.no> (02/04/18 1.383.13.52)
	[PATCH] Fix tcp_read_sock()

<trond.myklebust@fys.uio.no> (02/04/18 1.383.13.53)
	[PATCH] Do RPC over TCP reads in the bh fastpath...

<aia21@cus.cam.ac.uk> (02/04/18 1.383.13.54)
	[PATCH] Fix LDM compilation.

<davem@nuts.ninka.net> (02/04/18 1.383.11.6)
	Sparc64 fixes:

<trond.myklebust@fys.uio.no> (02/04/18 1.383.15.1)
	xprt.c:

<tony@cantech.net.au> (02/04/18 1.383.16.1)
	[PATCH] Change "return EBLAH" to "return -EBLAH in drivers/*

<greg@kroah.com> (02/04/18 1.383.16.2)
	USB whiteheat firmware

<greg@kroah.com> (02/04/18 1.383.16.3)
	USB whiteheat driver

<greg@kroah.com> (02/04/18 1.383.16.4)
	USB wacom driver

<johannes@erdfelt.com> (02/04/18 1.383.16.5)
	[PATCH] Re: removing sleep_on in hub.c

<david-b@pacbell.net> (02/04/18 1.383.16.6)
	[PATCH] USB devio device removal fix

<david-b@pacbell.net> (02/04/18 1.383.16.7)
	[PATCH] USB GeneLink/NDIS tweaks

<greg@kroah.com> (02/04/18 1.383.16.8)
	MAINTAINERS

<greg@kroah.com> (02/04/18 1.383.16.9)
	USB storage

<david-b@pacbell.net> (02/04/18 1.383.16.10)
	[PATCH] EHCI and Intel/VIA/Philips/...

<oliver@neukum.name> (02/04/18 1.383.16.11)
	[PATCH] added device id for hpusbscsi

<greg@kroah.com> (02/04/18 1.383.16.12)
	removed duplicate MATAINERS entry for Petko

<Robert.Olsson@data.slu.se> (02/04/18 1.383.17.1)
	Net pktgen updates:

<buytenh@gnu.org> (02/04/18 1.383.17.2)
	Bridging fix:

<davem@nuts.ninka.net> (02/04/19 1.383.11.7)
	Sparc: Pass sigcontext in to signal handlers properly

<davem@nuts.ninka.net> (02/04/21 1.383.11.8)
	ATYFB driver gcc-3.1 build fix: Dont put const object into initdata.

<davem@nuts.ninka.net> (02/04/22 1.383.11.9)
	PM2FB driver gcc-3.1 build fix: Dont put const object into initdata.

<davem@nuts.ninka.net> (02/04/22 1.383.11.10)
	Sparc64 ebus: Kill __FUNCTION__ pasting.

<rusty@rustcorp.com.au> (02/04/22 1.383.18.1)
	[PATCH] TRIVIAL 2.4.19-pre7: i386_pci-pc.c warning

<davem@nuts.ninka.net> (02/04/23 1.383.11.11)
	SunGEM bug fix:

<kuznet@ms2.inr.ac.ru> (02/04/23 1.383.17.3)
	Net fixes:

<buytenh@gnu.org> (02/04/23 1.383.17.4)
	Bridging fix:

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.18.3)
	Update NBD URL

<rusty@rustcorp.com.au> (02/04/23 1.383.18.4)
	[PATCH] TRIVIAL 2.4.19-pre7: newline in printk in olympic driver

<rusty@rustcorp.com.au> (02/04/23 1.383.18.5)
	[PATCH] TRIVIAL 2.4.19-pre7: Configure.help "neet" typo fix:

<rusty@rustcorp.com.au> (02/04/23 1.383.18.6)
	[PATCH] TRIVIAL 2.4.19-pre7: request_region in acornscsi.c

<rusty@rustcorp.com.au> (02/04/23 1.383.18.7)
	[PATCH] TRIVIAL 2.4.19-pre7: drivers_net_dl2k.c __devinit's

<rusty@rustcorp.com.au> (02/04/23 1.383.18.8)
	[PATCH] TRIVIAL 2.4.19-pre7: drivers_net_sis900.c: misiing

<rusty@rustcorp.com.au> (02/04/23 1.383.18.9)
	[PATCH] TRIVIAL 2.4.19-pre7: drivers_net_eepro100: missing

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.18.10)
	Revert Christoph's end_buffer_io_kiobuf change

<rgooch@ras.ucalgary.ca> (02/04/23 1.383.18.11)
	[PATCH] devfs update

<rusty@rustcorp.com.au> (02/04/23 1.383.18.12)
	[PATCH] TRIVIAL 2.4.19-pre7: Message changed in libc

<trini@kernel.crashing.org> (02/04/23 1.383.2.37)
	[PATCH] Add GPL v2 note to some PPC files

<maxk@qualcomm.com> (02/04/23 1.383.2.38)
	GCCs older than 2.95 do not like __func__ thing, patch provided below fixes

<maxk@qualcomm.com> (02/04/23 1.383.2.39)
	This patch fixes HCI filter misbehavior on 64 bit platforms.

<Andries.Brouwer@cwi.nl> (02/04/23 1.383.2.40)
	[PATCH] In kd.h K_NUMLOCK/K_CAPSLOCK definitions are interchanged

<rusty@rustcorp.com.au> (02/04/23 1.383.2.41)
	[PATCH] TRIVIAL 2.4.19-pre7: netfilter overlap calc

<rusty@rustcorp.com.au> (02/04/23 1.383.2.42)
	[PATCH] TRIVIAL 2.4.19-pre7: Warn about ioctl collision

<rusty@rustcorp.com.au> (02/04/23 1.383.2.43)
	[PATCH] TRIVIAL 2.4.19-pre7: make TAGS to work with bitkeeper

<geert@linux-m68k.org> (02/04/23 1.383.2.44)
	Update MVME i82596 Ethernet driver

<geert@linux-m68k.org> (02/04/23 1.383.2.45)
	[PATCH] Yearly m68k update (part 43)

<geert@linux-m68k.org> (02/04/23 1.383.2.46)
	[PATCH] Yearly m68k update (part 44)

<geert@linux-m68k.org> (02/04/23 1.383.2.47)
	[PATCH] Yearly m68k update (part 45)

<geert@linux-m68k.org> (02/04/23 1.383.2.48)
	[PATCH] Yearly m68k update (part 46)

<geert@linux-m68k.org> (02/04/23 1.383.2.49)
	[PATCH] Yearly m68k update (part 47)

<geert@linux-m68k.org> (02/04/23 1.383.2.50)
	[PATCH] Yearly m68k update (part 48)

<geert@linux-m68k.org> (02/04/23 1.383.2.51)
	[PATCH] Yearly m68k update (part 49)

<geert@linux-m68k.org> (02/04/23 1.383.2.52)
	[PATCH] Yearly m68k update (part 50)

<geert@linux-m68k.org> (02/04/23 1.383.2.53)
	[PATCH] Yearly m68k update (part 51)

<geert@linux-m68k.org> (02/04/23 1.383.2.54)
	[PATCH] Yearly m68k update (part 52)

<geert@linux-m68k.org> (02/04/23 1.383.2.55)
	[PATCH] Yearly m68k update (part 53)

<geert@linux-m68k.org> (02/04/23 1.383.2.56)
	[PATCH] Yearly m68k update (part 54)

<geert@linux-m68k.org> (02/04/23 1.383.2.57)
	[PATCH] Yearly m68k update (part 55)

<geert@linux-m68k.org> (02/04/23 1.383.2.58)
	[PATCH] Yearly m68k update (part 56)

<geert@linux-m68k.org> (02/04/23 1.383.2.59)
	[PATCH] Yearly m68k update (part 57)

<geert@linux-m68k.org> (02/04/23 1.383.2.60)
	[PATCH] atyfb initdata

<rusty@rustcorp.com.au> (02/04/23 1.383.2.61)
	[PATCH] TRIVIAL 2.4.19-pre7: request_region for via82c505.c

<rusty@rustcorp.com.au> (02/04/23 1.383.2.62)
	[PATCH] TRIVIAL 2.4.19-pre7: msbusmouse.c

<rusty@rustcorp.com.au> (02/04/23 1.383.2.63)
	[PATCH] TRIVIAL 2.4.19-pre7: logibusmouse.c

<rusty@rustcorp.com.au> (02/04/23 1.383.2.64)
	[PATCH] TRIVIAL 2.4.19-pre7: smp_call_function not allowed from bh

<rusty@rustcorp.com.au> (02/04/23 1.383.2.65)
	[PATCH] TRIVIAL 2.4.19-pre7: net_ipv6_sit.c wrong net_device

<alan@lxorguk.ukuu.org.uk> (02/04/23 1.383.2.66)
	[PATCH] PATCH: updated IBM ServeRAID driver

<kuebelr@email.uc.edu> (02/04/23 1.383.2.67)
	[PATCH] spelling mistakes

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.2.68)
	Fix nfs_create_request to not wip current->policy

<trond.myklebust@fys.uio.no> (02/04/23 1.383.2.70)
	[PATCH] Fix warnings from sunrpc tcp changes

<trini@kernel.crashing.org> (02/04/23 1.383.2.71)
	[PATCH] Fixup drivers/Makefile for drivers/macintosh as well

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.2.72)
	cpqarray driver update

<Martin.Bligh@us.ibm.com> (02/04/23 1.383.2.73)
	[PATCH] stop NULL pointer dereference in __alloc_pages

<greg@kroah.com> (02/04/23 1.383.2.74)
	[PATCH] PCI Hotplug Config.in fix

<greg@kroah.com> (02/04/23 1.383.2.75)
	[PATCH] IBM PCI Hotplug fix

<marcelo@plucky.distro.conectiva> (02/04/23 1.383.2.76)
	Kees Cook email address changed

<davem@nuts.ninka.net> (02/04/24 1.383.17.5)
	Kill in_ntoa from the tree.  Use NIPQUAD instead.

<ebrower@usa.net> (02/04/24 1.383.11.12)
	Add Sparc Voyager power management support.

<davem@nuts.ninka.net> (02/04/24 1.383.17.6)
	Tigon3: Handle posted writes correctly.

<kaber@trash.net> (02/04/24 1.383.17.7)
	In pfifo packet scheduler use qdisc->dev

<trini@kernel.crashing.org> (02/04/24 1.383.17.8)
	Do not ask about ECONET suboptions

<tetapi@utu.fi> (02/04/25 1.383.11.13)
	SunGEM:

<anton@samba.org> (02/04/25 1.383.11.14)
	Sparc64 ioctl32 updates:

<davem@nuts.ninka.net> (02/04/26 1.383.11.15)
	Sparc64:

<stelian@popies.net> (02/04/29 1.383.19.1)
	Allow multiple processes to open the sonypi device

<bjorn.wesen@axis.com> (02/04/29 1.383.2.78)
	Cris arch update

<twaugh@redhat.com> (02/04/29 1.383.2.79)
	[PATCH] 2.4.19-pre7: SIIG cards

<twaugh@redhat.com> (02/04/29 1.383.2.80)
	[PATCH] 2.4.19-pre7: kernel-doc-nano-HOWTO fix

<hch@infradead.org> (02/04/29 1.383.2.81)
	[PATCH] x86 init cleanups

<hch@infradead.org> (02/04/29 1.383.2.82)
	[PATCH] optimize initialization of struct kiobuf

<hch@infradead.org> (02/04/29 1.383.2.83)
	[PATCH] fix Config.in breakage

<bcrl@redhat.com> (02/04/29 1.383.2.84)
	[PATCH] vsnprintf returns incorrect length

<hch@infradead.org> (02/04/29 1.383.2.85)
	[PATCH] sb_set_blocksize/sb_min_blocksize

<hch@infradead.org> (02/04/29 1.383.2.86)
	[PATCH] give important spinlocks their own cachelign

<davem@nuts.ninka.net> (02/04/29 1.383.11.16)
	Sparc64 fix pagetable leak:

<marcelo@plucky.distro.conectiva> (02/04/29 1.383.2.88)
	PPC64 update

<maxk@qualcomm.com> (02/04/29 1.383.2.89)
	Add support for ATM Ethernet bridging (RFC 2684)

<rob@osinvestor.com> (02/04/30 1.383.2.90)
	[PATCH] drivers/char/eurotechwdt.c

<mlocke@mvista.com> (02/04/30 1.383.2.91)
	Add 8xx PCMCIA socket driver

<neilb@cse.unsw.edu.au> (02/04/30 1.383.2.92)
	[PATCH] MicroMemory battery backed PCI RAM card support

<david@gibson.dropbear.id.au> (02/04/30 1.383.2.93)
	[PATCH] Update for orinoco driver

<adilger@clusterfs.com> (02/04/30 1.383.2.94)
	[PATCH] minor cleanup in ext3 code

<hch@infradead.org> (02/04/30 1.383.2.95)
	[PATCH] kill code duplication in buffer handling

<rob@osinvestor.com> (02/04/30 1.383.2.96)
	[PATCH] drivers/char/shwdt.c

<wstinson@infonie.fr> (02/05/01 1.389)
	request_region janitor update for sdla wan driver

<wstinson@infonie.fr> (02/05/01 1.390)
	baycom_ser_fdx hamradio driver request_region janitor updates:

<wstinson@infonie.fr> (02/05/01 1.383.1.3)
	request_region janitor update for megaraid scsi driver:

<wstinson@infonie.fr> (02/05/01 1.383.1.4)
	request_region janitor updates for ultrastor scsi driver:

<tony@cantech.net.au> (02/05/01 1.383.1.5)
	s/-Efoo/Efoo/ cleanup for drivers:

<ShingChuang@via.com.tw> (02/05/01 1.391)
	Add support for new chip to via-rhine net driver.

<mufasa@sis.com.tw> (02/05/01 1.392)
	Add support for SiS962 phy to sis900 net driver.

<andrea@suse.de> (02/05/02 1.383.2.97)
	[PATCH] Fix setitimer deadlock

<viro@math.psu.edu> (02/05/02 1.383.2.98)
	[PATCH] Fix UFS block size checks

<axboe@suse.de> (02/05/02 1.394)
	[PATCH] cdrom changer load timeout

<maxk@qualcomm.com> (02/05/02 1.397)
	[PATCH] 2.4.19-pre7 TUN/TAP driver readv/writev support

<hch@infradead.org> (02/05/02 1.398)
	[PATCH] add definition of yield()

<trini@kernel.crashing.org> (02/05/02 1.399)
	[PATCH] Fix winbond compile dependancy

<mason@suse.com> (02/05/02 1.400)
	[PATCH] reiserfs 64 bit fix

<barrow_dj@yahoo.com> (02/05/02 1.401)
	[PATCH] Fix SMP race condition on startup

<hermes@gibson.dropbear.id.au> (02/05/02 1.402)
	[PATCH] Orinoco 0.11b update

<marcelo@plucky.distro.conectiva> (02/05/02 1.403)
	Changed EXTRAVERSION to pre8

<marcelo@plucky.distro.conectiva> (02/05/02 1.404)
	Undo removal of __init from init_idle

Summary of changes from v2.4.19-pre6 to v2.4.19-pre7
============================================

<davem@nuts.ninka.net> (02/03/26 1.189.1.19)
	SunHME driver updates:

<davem@nuts.ninka.net> (02/03/27 1.181.2.39)
	Tigon3 net driver fixes:

<davem@nuts.ninka.net> (02/03/27 1.189.1.20)
	In SBUS probing, handle empty SBUS correctly.

<davem@nuts.ninka.net> (02/03/27 1.181.2.40)
	Tigon3 net driver bug fix:

<davem@nuts.ninka.net> (02/03/28 1.189.1.21)
	Make for_all_sbusdev handle an empty SBUS properly.

<davem@nuts.ninka.net> (02/03/28 1.181.2.41)
	Tigon3 driver update:

<rmk@flint.arm.linux.org.uk> (02/03/30 1.294.1.1)
	Prevent selection of ARM options with non-ARM architectures

<davem@nuts.ninka.net> (02/03/30 1.181.2.42)
	net/core/sock.c needs linux/tcp.h to get at TCP state macros.

<kai@tp1.ruhr-uni-bochum.de> (02/03/31 1.300.2.1)
	Use iounmap on ioremap'ed area.

<davem@nuts.ninka.net> (02/04/03 1.181.2.43)
	In tcp_sendmsg, make sure we jump to the out label

<davem@nuts.ninka.net> (02/04/03 1.181.2.44)
	Tigon3 driver pci_unmap_foo changes were half complete,

<davem@nuts.ninka.net> (02/04/04 1.189.1.22)
	Sparc64's flush_thread needs to initialize the PGD cache

<davem@nuts.ninka.net> (02/04/04 1.335.1.1)
	RTL8150 USB driver needs linux/init.h

<davem@nuts.ninka.net> (02/04/04 1.335.1.2)
	drivers/ieee1394/ohci1394.h uses readl/writel so it

<akpm@zip.com.au> (02/04/05 1.378)
	[PATCH] BUG bits

<marcelo@plucky.distro.conectiva> (02/04/05 1.379)
	added missing include

<trini@kernel.crashing.org> (02/04/05 1.382)
	[PATCH] Curse into drivers/macintosh on CONFIG_PPC

<viro@math.psu.edu> (02/04/05 1.383)
	[PATCH] fix for leak in get_anon_super()

<kaos@ocs.com.au> (02/04/07 1.383.2.1)
	[PATCH] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile

<kaos@ocs.com.au> (02/04/07 1.383.2.2)
	[PATCH] 2.4.19-pre6 standardize aacraid/Makefile

<prom@berlin.ccc.de> (02/04/07 1.383.2.3)
	[PATCH] radeonfb accelerator id in 2.4.19

<EdV@macrolink.com> (02/04/07 1.383.2.4)
	[PATCH] serial driver procfs 2.4.19-pre6

<hch@infradead.org> (02/04/07 1.383.2.5)
	[PATCH] highmem setup

<wim@iguana.be> (02/04/07 1.383.2.6)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

<wim@iguana.be> (02/04/07 1.383.2.7)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

<wim@iguana.be> (02/04/07 1.383.2.8)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

<kanoj@vger.kernel.org> (02/04/08 1.189.1.23)
	get_cycles() needs to be defined

<davem@nuts.ninka.net> (02/04/08 1.189.1.24)
	In math-emu/op-common.h:FP_FROM_INT, correct handling of

<davem@nuts.ninka.net> (02/04/08 1.189.1.25)
	Sparc64 math-emu fix:

<davem@nuts.ninka.net> (02/04/08 1.335.1.3)
	Generate dependencies in include/math-emu

<davem@nuts.ninka.net> (02/04/08 1.189.1.26)
	Update sparc64 defconfig.

<davem@nuts.ninka.net> (02/04/08 1.335.1.4)
	Use include <math-emu/foo.h> instead of "foo.h" in

<johannes@erdfelt.com> (02/04/08 1.383.3.1)
	[PATCH] uhci.c 2.4.19-pre6 SMP deadlock

<johannes@erdfelt.com> (02/04/08 1.383.3.2)
	[PATCH] uhci.c 2.4.19-pre6 cleanup

<johannes@erdfelt.com> (02/04/08 1.383.3.3)
	[PATCH] uhci.c 2.4.19-pre6 incorrect locking

<johannes@erdfelt.com> (02/04/08 1.383.3.4)
	[PATCH] uhci.c 2.4.19-pre6 FSBR speed problem

<greg@kroah.com> (02/04/08 1.383.3.5)
	added Petko's maintainer info for the rtl8150 USB driver.

<greg@kroah.com> (02/04/08 1.383.3.6)
	USB visor driver

<msw@redhat.com> (02/04/08 1.383.3.7)
	USB wacom driver.

<greg@kroah.com> (02/04/08 1.383.3.8)
	USB usb-uhci driver

<davem@nuts.ninka.net> (02/04/09 1.189.1.27)
	Sparc64: Fix elf_gregset_t layout for native 64-bit binaries.

<davem@nuts.ninka.net> (02/04/09 1.335.1.5)
	Fix typo in previous math-emu/soft-fp.h changes

<bcrl@redhat.com> (02/04/10 1.181.2.45)
	Rearrange some int members of

<trini@kernel.crashing.org> (02/04/10 1.181.2.46)
	CONFIG_APPLETALK and

<davem@nuts.ninka.net> (02/04/10 1.335.1.6)
	drivers/ide/ide.c: Do not assume u64 == unsigned long long

<davem@nuts.ninka.net> (02/04/10 1.335.1.7)
	drivers/ide/ide-proc.c: Do not assume u64 == unsigned long long

<rddunlap@osdl.org> (02/04/10 1.181.2.47)
	Remove bogus networking stats

<uzi@uzix.org> (02/04/10 1.189.1.28)
	Sparc32 fixes:

<laforge@gnumonks.org> (02/04/10 1.181.2.48)
	IPv6 netfilter fixes:

<trond.myklebust@fys.uio.no> (02/04/10 1.181.2.49)
	Add tcp_read_sock which allows one to

<davem@nuts.ninka.net> (02/04/10 1.383.4.2)
	fs/nfsd/nfsctl.c: Include linux/init.h

<akpm@zip.com.au> (02/04/11 1.383.4.4)
	[PATCH] fix ext3 i_blocks accounting

<rgooch@ras.ucalgary.ca> (02/04/11 1.383.4.5)
	[PATCH] devfs update

<rml@tech9.net> (02/04/11 1.383.4.6)
	[PATCH] Re: [PATCH] 2.4: reserve syscalls from 2.5

<hch@infradead.org> (02/04/11 1.383.4.7)
	[PATCH] rlimit vs bdev in pagecache

<hch@infradead.org> (02/04/11 1.383.4.8)
	[PATCH] really write out inodes

<hch@infradead.org> (02/04/11 1.383.4.9)
	[PATCH] forward raw device ioctls

<hch@infradead.org> (02/04/11 1.383.4.10)
	[PATCH] kmem_cache_shrink return value

<rusty@rustcorp.com.au> (02/04/11 1.383.4.11)
	[PATCH] Re: [PATCH] TRIVIAL 2.4.19-pre5: adjtimex and SINGLESHOT

<zaitcev@redhat.com> (02/04/11 1.383.4.12)
	[PATCH] sd.c and 128 SCSI disks

<benh@kernel.crashing.org> (02/04/11 1.383.2.11)
	This patch updates several of the PPC-specific drivers in

<paulus@samba.org> (02/04/11 1.383.2.12)
	[PATCH] PPC update for 2.4.19-pre6

<marcelo@plucky.distro.conectiva> (02/04/11 1.383.2.13)
	Added missing "linux/init.h" include.

<jbglaw@lug-owl.de> (02/04/11 1.383.2.14)
	[PATCH] Update for ./arch/alpha/kernel/srm_env.c driver

<bjorn_helgaas@hp.com> (02/04/11 1.383.2.15)
	[PATCH] [PATCH] agpgart support for HP ZX1

<hch@infradead.org> (02/04/11 1.383.2.16)
	[PATCH] OOM killer updates

<riel@conectiva.com.br> (02/04/11 1.383.2.17)
	[PATCH] remove compiler.h from mmap.c

<marcelo@plucky.distro.conectiva> (02/04/12 1.383.2.18)
	Changed ext2/ext3 MAINTAINERS file entries

<kai@tp1.ruhr-uni-bochum.de> (02/04/14 1.383.9.1)
	Add support for ISDN card USR PCI TA

<marc@mbsi.ca> (02/04/15 1.383.2.19)
	[PATCH] yet another VAIO dmi_blacklist entry

<maxk@qualcomm.com> (02/04/15 1.383.2.20)
	Bluetooth subsystem sync up

<gibbs@scsiguy.com> (02/04/15 1.383.2.21)
	[PATCH] sd.c fixes applied incorectly to 2.4.19-preXX

<gibbs@scsiguy.com> (02/04/15 1.383.2.22)
	[PATCH] Aic7xxx driver version 6.2.6

<hch@infradead.org> (02/04/15 1.383.2.24)
	[PATCH] disable APIC when broken mptable is found

<hch@infradead.org> (02/04/15 1.383.2.25)
	[PATCH] mem= command lines fixes.

<hch@infradead.org> (02/04/15 1.383.2.26)
	[PATCH] unlock buffer_head _after_ end_kio_request

<hch@infradead.org> (02/04/15 1.383.2.27)
	[PATCH] allow forcing APIC mode

<kaos@ocs.com.au> (02/04/15 1.383.2.28)
	[PATCH] Standardise the frame pointer compile option

<arjanv@redhat.com> (02/04/15 1.383.2.29)
	[PATCH] Add missing ataraid entries

<khalid_aziz@hp.com> (02/04/15 1.383.2.30)
	[PATCH] HCDP serial ports

<marcelo@plucky.distro.conectiva> (02/04/16 1.383.2.31)
	Add missing code from the IDE merge

<hch@infradead.org> (02/04/16 1.383.2.32)
	[PATCH] generate nice manpages from kernel-doc

<marcelo@plucky.distro.conectiva> (02/04/16 1.383.2.33)
	Changed EXTRAVERSION to pre7

<marcelo@plucky.distro.conectiva> (02/04/16 1.383.2.34)
	Removed duplicated init.h include

Summary of changes from v2.4.19-pre5 to v2.4.19-pre6
============================================

<vojtech@suse.cz> (02/04/01 1.311)
	[PATCH] Fixes for non-legacy gameports.

<manfred@colorfullife.com> (02/04/01 1.312)
	[PATCH] block/IDE/interrupt lockup fix

<martin@meltin.net> (02/04/01 1.313)
	[PATCH] Patch to pull NFS server address off root_server_path

<akpm@zip.com.au> (02/04/01 1.314)
	[PATCH] Let all hptraid ioctls to throught the block layer

<viro@math.psu.edu> (02/04/01 1.315)
	Cleans do_remount_sb() up and docbookifies it.

<viro@math.psu.edu> (02/04/01 1.316)
	Slightly cleans up the handling of anon. devices,

<viro@math.psu.edu> (02/04/01 1.317)
	Obvious cleanups in get_sb_bdev().

<viro@math.psu.edu> (02/04/01 1.318)
	* capability check moved from do_kern_mount() into do_add_mount().

<viro@math.psu.edu> (02/04/01 1.319)
	rootfs made an alias of ramfs.

<viro@math.psu.edu> (02/04/01 1.320)
	Removes lock_super()/unlock_super() from callers of ->read_super().

<viro@math.psu.edu> (02/04/01 1.321)
	mount_sem turned into rwsem.  The only reader is handling of

<viro@math.psu.edu> (02/04/01 1.322)
	turns (mount_sem,vfsmntlist,root_vfsmnt) into per-process object

<viro@math.psu.edu> (02/04/01 1.323)
	makes /proc/mounts a symlink to /proc/<pid>/mounts.

<viro@math.psu.edu> (02/04/01 1.324)
	kills set_devname(), makes "name" an argument of alloc_vfsmnt().

<bcrl@redhat.com> (02/04/01 1.325)
	The patch below fixes a problem whereby a vma which has its vm_start

<arjanv@redhat.com> (02/04/02 1.326)
	[PATCH] dma_addr_t vs highmem

<greg@kroah.com> (02/04/02 1.300.3.1)
	USB visor driver

<greg@kroah.com> (02/04/02 1.300.3.2)
	USB HID driver fixes

<bhards@bigpond.net.au> (02/04/02 1.300.3.3)
	USB CDCEther driver update

<petkan@mastika.lnxw.com> (02/04/02 1.300.3.4)
	USB

<david-b@pacbell.net> (02/04/02 1.300.3.5)
	USB hcd core

<david-b@pacbell.net> (02/04/02 1.300.3.6)
	USB ohci driver fixes

<petkan@mastika.lnxw.com> (02/04/02 1.300.3.7)
	USB pegasus driver

<suse.cz@mastika.lnxw.com> (02/04/02 1.300.3.8)
	USB

<johannes@erdfelt.com> (02/04/02 1.300.3.9)
	USB uhci

<greg@kroah.com> (02/04/02 1.300.3.10)
	USB

<stelian@popies.net> (02/04/03 1.327)
	Enable more accurate events on Vaio laptops without a jogdial (FX series)

<kaos@ocs.com.au> (02/04/03 1.326.1.1)
	[PATCH] 2.4.19-pre5 Makefile standardization

<jaharkes@cs.cmu.edu> (02/04/03 1.326.1.2)
	[PATCH] 2.4.19-pre5 Coda update

<marcelo@plucky.distro.conectiva> (02/04/03 1.326.1.3)
	Removed the EXPERIMENTAL mark of fs/Config.in ext3 entry.

<marcelo@plucky.distro.conectiva> (02/04/03 1.329)
	Cosmetic fix to avoid the agpgart detection

<rml@tech9.net> (02/04/03 1.330)
	[PATCH] 2.4: BUG_ON (1/2)

<rml@tech9.net> (02/04/03 1.331)
	[PATCH] 2.4: BUG_ON (2/2)

<marcelo@plucky.distro.conectiva> (02/04/03 1.332)
	Re add MWAVE Config.in entry

<rusty@rustcorp.com.au> (02/04/03 1.333)
	[PATCH] TRIVIAL 2.4.19-pre5: PPC leapyear fix

<marcelo@plucky.distro.conectiva> (02/04/03 1.334)
	Add ALi 1644 support to AGP

<bcrl@redhat.com> (02/04/04 1.335)
	[PATCH] Update mmap patch

<sam@minnie.(none)> (02/04/04 1.326.2.1)
	tlan.c:

<ioshadij@hotmail.com> (02/04/04 1.336)
	[PATCH] kjournald locking fix

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.337)
	[PATCH] PATCH: regenerated against new tree - Configs

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.338)
	[PATCH] PATCH: make indydog use long for bitops

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.339)
	[PATCH] PATCH: wdt285 error returns

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.340)
	[PATCH] PATCH: silly doc fix

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.341)
	[PATCH] PATCH: also add bridge resources to resource tree

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.342)
	[PATCH] PATCH: returns on error fixes for sound

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.343)
	[PATCH] PATCH: make the mad16 use the newer input/gameport api right

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.344)
	[PATCH] PATCH: yet more sound error returns

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.345)
	[PATCH] PATCH: and one or two more for luck 8)

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.346)
	[PATCH] PATCH: only flush block on the last close

<alan@lxorguk.ukuu.org.uk> (02/04/04 1.347)
	[PATCH] PATCH: missing neomagic include bits

<hch@infradead.org> (02/04/04 1.348)
	[PATCH] SARD

<viro@math.psu.edu> (02/04/04 1.349)
	[PATCH] IS_DEADDIR() checks

<rusty@rustcorp.com.au> (02/04/04 1.350)
	[PATCH] TRIVIAL 2.4.19-pre5: documentation fix

<trini@kernel.crashing.org> (02/04/04 1.351)
	[PATCH] Don't always ask about Intel or AMD RNGs

<rusty@rustcorp.com.au> (02/04/05 1.353)
	[PATCH] TRIVIAL 2.4.19-pre5: fcntl (F_DUPFD) return

<neilb@cse.unsw.edu.au> (02/04/05 1.354)
	[PATCH] PATCH 1 of 16 - Fix problems with raid1 resync code.

<neilb@cse.unsw.edu.au> (02/04/05 1.355)
	[PATCH] PATCH 2 of 16 - Flush out final sync requests on an idle system.

<neilb@cse.unsw.edu.au> (02/04/05 1.356)
	[PATCH] PATCH 3 of 16 - Remove exp_find, it is never used

<neilb@cse.unsw.edu.au> (02/04/05 1.357)
	[PATCH] PATCH 4 of 16 - read_lock the export table when lockd calls

<neilb@cse.unsw.edu.au> (02/04/05 1.358)
	[PATCH] PATCH 5 of 16 - Fix possible leak of mnt/dentry references.

<neilb@cse.unsw.edu.au> (02/04/05 1.359)
	[PATCH] PATCH 6 of 16 - Use MKDEV for making device number from components

<neilb@cse.unsw.edu.au> (02/04/05 1.360)
	[PATCH] PATCH 7 of 16 - Central updating of fh_stale statistics.

<neilb@cse.unsw.edu.au> (02/04/05 1.361)
	[PATCH] PATCH 8 of 16 - Get nfsd_setattr to not put too much weight on

<neilb@cse.unsw.edu.au> (02/04/05 1.362)
	[PATCH] PATCH 9 of 16 - Tidy up some vfs calls in nfsd

<neilb@cse.unsw.edu.au> (02/04/05 1.363)
	[PATCH] PATCH 12 of 16 - Stop fat_fh_to_dentry returning NULL + set

<neilb@cse.unsw.edu.au> (02/04/05 1.364)
	[PATCH] PATCH 10 of 16 - Cleanup the syscall interface to nfsd

<neilb@cse.unsw.edu.au> (02/04/05 1.365)
	[PATCH] PATCH 13 of 16 - Tidy up exp_get code

<neilb@cse.unsw.edu.au> (02/04/05 1.366)
	[PATCH] PATCH 14 of 16 - Change exports hash lists to list.h lists

<neilb@cse.unsw.edu.au> (02/04/05 1.367)
	[PATCH] PATCH 15 of 16 - Link exports for a given client together

<neilb@cse.unsw.edu.au> (02/04/05 1.368)
	[PATCH] PATCH 16 of 16 - Change /proc/fs/nfs/exports to use seq_file

<viro@math.psu.edu> (02/04/05 1.369)
	kills floppy_eject(), replacing it with normal open()/ioctl()/close().

<viro@math.psu.edu> (02/04/05 1.370)
	moves initrd-related options (rd_doload, etc.) into do_mounts.c

<viro@math.psu.edu> (02/04/05 1.371)
	switches wait_for_keypress() to normal syscalls.

<viro@math.psu.edu> (02/04/05 1.372)
	moves devfs_make_root() to do_mounts.c and cleans it up.

<Lionel.Bouton@inet6.fr> (02/04/05 1.373)
	[PATCH] Against 2.4.19-pre5, Bugfixes

<kaos@ocs.com.au> (02/04/05 1.374)
	[PATCH] 2.4.19-pre5 prevent user space includes

<marcelo@plucky.distro.conectiva> (02/04/05 1.375)
	Changed EXTRAVERSION to pre6

<neilb@cse.unsw.edu.au> (02/04/05 1.376)
	[PATCH] Re: PATCH 11 of 16 - Tidyup init/exit fof nfsd module

Summary of changes from v2.4.19-pre4 to v2.4.19-pre5
============================================

<sawa@yamamoto.gr.jp> (02/03/15 1.197.1.1)
	Fix bug in at1700 net driver:

<jgarzik@mandrakesoft.com> (02/03/15 1.197.1.2)
	pcnet32 net driver update 1/6:

<anton@samba.org> (02/03/15 1.197.1.3)
	pcnet32 net driver updates 2/6:

<anton@samba.org> (02/03/15 1.197.1.4)
	pcnet32 net driver updates 3/6:

<anton@samba.org> (02/03/15 1.197.1.5)
	pcnet32 net driver updates 4/6:

<anton@samba.org> (02/03/15 1.197.1.6)
	pcnet32 net driver updates 5/6:

<anton@samba.org> (02/03/15 1.197.1.7)
	pcnet32 net driver updates 6/6:

<jes@wildopensource.com> (02/03/15 1.197.1.8)
	acenic gige net driver update:

<jes@wildopensource.com> (02/03/15 1.197.1.9)
	acenic driver fixes:

<jt@bougret.hpl.hp.com> (02/03/15 1.197.1.10)
	Convert hp100 net driver to PCI DMA mapping API.

<jgarzik@mandrakesoft.com> (02/03/15 1.197.1.11)
	Don't include linux/delay.h twice in eepro100 net driver.

<davem@nuts.ninka.net> (02/03/19 1.181.2.10)
	Netfilter enhancement from Harald Welte and Netfilter team.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.11)
	Remove obsolete confusing instructions on tcp_max_syn_backlog

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.12)
	Make pkt_sched.h:PSCHED_TDIFF_SAFE behave sane when measuring

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.13)
	Remove unused field from TCP struct open_request.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.14)
	Do not fail creating _new_ NOARP entry with EPERM.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.15)
	Old bug in skbuff.c, found by someone, but was lost.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.16)
	IPv4 FIB routing fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.17)
	In IPv4 ICMP:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.18)
	Fix for ipv4 tunnel devices:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.19)
	IP input fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.20)
	Terrible bug in ipv4/route.c, mis-sized ip_rt_acct leads to

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.21)
	TCP Input fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.22)
	UDP fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.23)
	IPV6 addrconf exploit fix:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.24)
	IPv6 neighbour discovery fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.25)
	TCP ipv6 fixes:

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.26)
	Port of 2.2.x AF_PACKET bug fix.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.27)
	Fix bug in sch_prio.c where wrong handle was

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.28)
	In sch_sfq.c, allow to descrease length of queue

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.29)
	Add new sysctl, medium_id, to devinet.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.30)
	Forgotten portion of "kill unused struct open_request" changes.

<kuznet@ms2.inr.ac.ru> (02/03/19 1.181.2.31)
	Allow to bind to an already in use local port

<davem@nuts.ninka.net> (02/03/19 1.189.1.1)
	Update sparc64 defconfig.

<kanojsarcar@yahoo.com> (02/03/19 1.189.1.2)
	Move VPTE_BASE_foo definitions to common

<kraxel@bytesex.org> (02/03/20 1.221)
	fix compile error due to recent videodev changes

<kraxel@bytesex.org> (02/03/20 1.222)
	fix compile error due to recent videodev changes

<edward_peng@dlink.com.tw> (02/03/20 1.220.1.3)
	Update dl2k gigabit ethernet driver to watch RX in case of lockup.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.4)
	dl2k net driver updates:

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.5)
	Add pci id to orinoco_plx wireless driver (Brendan McAdams)

<jgarzik@mandrakesoft.com> (02/03/20 1.220.2.2)
	Add two AC97 codec ids to the OSS ac97_codec driver.

<jes@wildopensource.com> (02/03/20 1.220.1.6)
	Update acenic gigabit ethernet driver to clean up VLAN support integration.

<k.kasprzak@box43.pl> (02/03/20 1.220.1.7)
	de620 net driver janitor fixes:

<silicon@falcon.sch.bme.hu> (02/03/20 1.220.2.3)
	Update munich WAN driver to not kfree memory multiple times.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.8)
	s/kfree/kfree_skb/ in drivers/s390/net/ctctty.c.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.9)
	(sync with 2.5.x.  in 2.4.x, this is just a cosmetic change)

<brownfld@irridia.com> (02/03/20 1.220.1.10)
	Support second port on dual-port SysConnect SK-9844 NICs.

<p_gortmaker@yahoo.com> (02/03/20 1.220.1.11)
	MODULE_DESC net drivers cleanup.

<go@turbolinux.co.jp> (02/03/20 1.220.1.12)
	Update pcnet32 net driver with the following changes:

<arjanv@redhat.com> (02/03/20 1.220.1.13)
	Revert xircom_cb net driver back to earlier version which works in all cases.

<arjanv@redhat.com> (02/03/20 1.220.1.14)
	Increase eepro100 net driver tx/rx ring sizes, to be more appropriate for 100mbit

<arjanv@redhat.com> (02/03/20 1.220.1.15)
	Add eepro100 net driver rx soft reset function.

<arjanv@redhat.com> (02/03/20 1.220.1.16)
	Implement RX soft reset for certain cases in eepro100 net driver.

<arjanv@redhat.com> (02/03/20 1.220.1.17)
	Update eepro100 net driver to properly enable/disable software timer

<arjanv@redhat.com> (02/03/20 1.220.1.18)
	eepro100 net driver h/w bug workaround updates:

<arjanv@redhat.com> (02/03/20 1.220.1.19)
	Move pci_enable_device and associated code above first PCI resource info access.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.20)
	Build fix: include linux/crc32.h in bmac net driver.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.21)
	Merge include/asm-i386/checksum.h from 2.5.7.

<jgarzik@mandrakesoft.com> (02/03/20 1.220.1.22)
	Revert 2.4.18 epic100 net driver power-up sequence "fix".

<davem@nuts.ninka.net> (02/03/20 1.189.1.3)
	In sparc64/ebus, handle machines with both RIO and

<davem@nuts.ninka.net> (02/03/20 1.189.1.4)
	On sparc64 Schizo PCI controllers, there is no inofixup

<davem@nuts.ninka.net> (02/03/20 1.189.1.5)
	On sparc64, handle assigning ROM and non-standard resources

<davem@nuts.ninka.net> (02/03/20 1.189.1.6)
	In Sun GEM/HME drivers, if OpenBoot firmware is not

<davem@nuts.ninka.net> (02/03/20 1.189.1.7)
	Model Sparc64 pci_assign_resource more closely to the

<davem@nuts.ninka.net> (02/03/20 1.189.1.8)
	SunHME net driver cleanups:

<davem@nuts.ninka.net> (02/03/20 1.181.2.32)
	Bonding driver updates:

<dwmw2@infradead.org> (02/03/21 1.220.2.5)
	 The safe parts of the newer MTD code:

<davem@nuts.ninka.net> (02/03/21 1.189.1.9)
	In Sun GEM/HME drivers, if pci_assign_resource of PCI ROM fails,

<dwmw2@infradead.org> (02/03/21 1.220.2.6)
	Merge

<davem@nuts.ninka.net> (02/03/21 1.189.1.10)
	Remove debugging printk while probing MAC address.

<davem@nuts.ninka.net> (02/03/21 1.189.1.11)
	Sun HME/GEM driver probing cleanups.

<davem@nuts.ninka.net> (02/03/21 1.181.2.33)
	Add missing KERN_foo printk specifiers to networking.

<uzi@uzix.org> (02/03/21 1.189.1.12)
	Merge 2.4.x VGER sparc32 changes into 2.4.19

<laforge@gnumonks.org> (02/03/21 1.181.2.34)
	Add configure Configure.help message and

<wstinson@infonie.fr> (02/03/21 1.189.1.13)
	Remove explicit initialization of static vars to zero

<cruault@724.com> (02/03/21 1.181.2.35)
	Make sure outgoing ICMP and TCP resets

<davem@nuts.ninka.net> (02/03/21 1.189.1.14)
	Move bootstr_valid/bootstr_buf back into .data section.

<dwmw2@dwmw2.baythorne.internal> (02/03/22 1.220.2.7)
	Add drivers/mtd/mtdconcat.o to export-objs

<dwmw2@infradead.org> (02/03/22 1.220.2.8)
	Make the partial MTD merge actually compile without warnings.

<dwmw2@infradead.org> (02/03/22 1.220.2.9)
	Minor JFFS2 fixes.

<davem@nuts.ninka.net> (02/03/22 1.181.2.36)
	Code (and commentary) in SYN-RECEIVED processing

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.24)
	Add Promise 20276 to supported IDE controllers

<kaos@ocs.com.au> (02/03/22 1.220.1.25)
	[PATCH] 2.4.19-pre4 remove include modversions.h

<sfr@canb.auug.org.au> (02/03/22 1.220.1.26)
	[PATCH] APM missing bits from 2.4.19-pre4

<hch@infradead.org> (02/03/22 1.220.1.27)
	[PATCH] Alpha extern inline -> static inline

<hch@infradead.org> (02/03/22 1.220.1.28)
	[PATCH] alpha lseek prototype

<hch@infradead.org> (02/03/22 1.220.1.29)
	[PATCH] Alpha exports

<hch@infradead.org> (02/03/22 1.220.1.30)
	[PATCH] Alpha fixes for hashed page waitqueues from -aa

<davem@nuts.ninka.net> (02/03/22 1.181.2.37)
	Bump TcpPassiveOpens when tcp_create_openreq_child succeeds.

<hch@infradead.org> (02/03/22 1.220.1.32)
	[PATCH] remove wake_up_page

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.33)
	Remove Pacific Digital A-DMA support in Config.in

<alfre@IBD.es> (02/03/22 1.220.1.34)
	[PATCH] Too much debug info from ide-tape

<akpm@zip.com.au> (02/03/22 1.220.1.37)
	[PATCH] smaller kernels

<axboe@suse.de> (02/03/22 1.220.1.38)
	[PATCH] UDF read-write 2.4.19-pre4 bug

<rusty@rustcorp.com.au> (02/03/22 1.220.1.39)
	[PATCH] 2.4.19-pre4 Trivial II: APM update

<rusty@rustcorp.com.au> (02/03/22 1.220.1.40)
	[PATCH] 2.4.19-pre4 Trivial III: SAK message.

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.42)
	When writing too little (0) or too much (>num_physpages) of microcode data

<bunk@fs.tum.de> (02/03/22 1.220.1.43)
	[PATCH] s/malloc.h/slab.h/ in sis_ds.c

<bunk@fs.tum.de> (02/03/22 1.220.1.44)
	[PATCH] Don't offer CONFIG_INDYDOG on non-ip22 machines

<akpm@zip.com.au> (02/03/22 1.220.1.45)
	[PATCH] x86 BUG handling

<greg@kroah.com> (02/03/22 1.220.6.1)
	USB visor driver

<marcelo@plucky.distro.conectiva> (02/03/22 1.220.1.46)
	Remove option to use the noop elevator

<petkan@mastika.> (02/03/22 1.220.6.2)
	USB pegasus driver

<oliver@oenone.homelinux.org> (02/03/22 1.220.6.3)
	USB hpusbscsi driver

<oliver@oenone.homelinux.org> (02/03/22 1.220.6.4)
	USB kaweth driver

<paschal@rcsis.com> (02/03/22 1.220.6.5)
	USB printer driver

<vojtech@suse.cz> (02/03/22 1.220.6.6)
	USB HID driver

<nemosoft@smcc.demon.nl> (02/03/22 1.220.6.7)
	USB pwc driver

<john@larvalstage.com> (02/03/22 1.220.1.47)
	[PATCH] trivial borken compile fixes for 2.4.19-pre4

<greg@kroah.com> (02/03/22 1.220.6.8)
	USB hub

<greg@kroah.com> (02/03/22 1.220.6.9)
	USB hub

<ganesh@tuxtop.vxindia.veritas.com> (02/03/22 1.220.6.10)
	USB ipaq driver

<david-b@pacbell.net> (02/03/22 1.220.6.11)
	USB ohci and unlink-in-completion

<david-b@pacbell.net> (02/03/22 1.220.6.12)
	USB update documentation

<johannes@erdfelt.com> (02/03/22 1.220.6.13)
	USB uhci driver update

<greg@kroah.com> (02/03/22 1.220.6.14)
	USB core

<david-b@pacbell.net> (02/03/22 1.220.6.15)
	USB usbfs periodic endpoint/bandwidth reporting

<rmk@flint.arm.linux.org.uk> (02/03/23 1.220.7.1)
	Initial update - all ARM files to 2.4.18-rmk3.

<marcelo@plucky.distro.conectiva> (02/03/25 1.220.1.48)
	Import PPC64 port

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.224)
	[PATCH] Neomagic frame buffer author

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.225)
	[PATCH] PATCH: reiserfs stuff

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.226)
	[PATCH] PATCH: updated IDE - docs

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.227)
	[PATCH] PATCH: docs for neomagic fb

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.228)
	[PATCH] PATCH: docs for 3c509

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.229)
	[PATCH] PATCH: docs for RME hammerfall

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.230)
	[PATCH] PATCH: Updated Andre info

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.231)
	[PATCH] PATCH: printk levels

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.232)
	[PATCH] PATCH: comment fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.233)
	[PATCH] PATCH: printk level fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.234)
	[PATCH] PATCH: ITE8330 IRQ router

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.235)
	[PATCH] PATCH: printk levels ctd

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.236)
	[PATCH] PATCH: more printk levels

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.237)
	[PATCH] PATCH: new XD signature

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.238)
	[PATCH] PATCH: config.in fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.239)
	[PATCH] PATCH: add config for mk712 touchscreen

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.240)
	[PATCH] PATCH: config.in for AMD768 rng

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.241)
	[PATCH] PATCH: Ali watchdog

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.242)
	[PATCH] PATCH: mk712 touchscreen

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.243)
	[PATCH] PATCH: natsemi watchdogs

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.244)
	[PATCH] PATCH: update w83 watchdog

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.245)
	[PATCH] PATCH: add wafer watchdog

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.246)
	[PATCH] PATCH: wdt/wdt_pci fixes and cleanup

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.247)
	[PATCH] PATCH: fix timeout in zoran driver

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.248)
	[PATCH] PATCH: fix config/makefile crud

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.249)
	[PATCH] PATCH: fix timeout in arlan

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.250)
	[PATCH] PATCH: update MPT fusion drivers to 2.0 to handle new boards

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.251)
	[PATCH] PATCH: fix iph5526 to relax cpu

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.252)
	[PATCH] PATCH: fix resource bug in lance

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.253)
	[PATCH] PATCH: compile warning fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.254)
	[PATCH] PATCH: fix resource handling in wd.c

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.255)
	[PATCH] PATCH: Add ZV bus to Ricoh cards

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.256)
	[PATCH] PATCH: new style initializers for s390 hwcon

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.257)
	[PATCH] PATCH: time_foo for gdth

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.258)
	[PATCH] PATCH: time_fu for qlogic

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.259)
	[PATCH] PATCH: add another sparselun entry

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.260)
	[PATCH] PATCH: rme hammerfall update

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.261)
	[PATCH] PATCH: minor sound bits

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.262)
	[PATCH] PATCH: missing dependancy

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.263)
	[PATCH] PATCH: missing reparent_to_init

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.264)
	[PATCH] PATCH: more time fixes

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.265)
	[PATCH] PATCH: printk level

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.266)
	[PATCH] PATCH: minor number for mk712

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.267)
	[PATCH] PATCH: acct race fix

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.268)
	[PATCH] PATCH: fix strange httpd logging bug

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.269)
	[PATCH] PATCH: help for patch-kernel

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.270)
	[PATCH] PATCH: config changes to enable neomagic to be selected

<alan@lxorguk.ukuu.org.uk> (02/03/25 1.271)
	[PATCH] PATCH: char Makefile - new watchdogs, mk712 etc

<marcelo@plucky.distro.conectiva> (02/03/25 1.273)
	Re-add all asserts removed by akpm's out-of-line-BUG patch

<marcelo@plucky.distro.conectiva> (02/03/25 1.274)
	ieee1394 update

<marcelo@plucky.distro.conectiva> (02/03/25 1.275)
	Makes rd_load_image() return 0 if it had failed and 1 if it was

<marcelo@plucky.distro.conectiva> (02/03/25 1.276)
	initrd_load() moved to do_mounts.c; assigning DEV_ROOT in case of

<marcelo@plucky.distro.conectiva> (02/03/25 1.277)
	code that deals with spawning /linuxrc, waiting for it, calling

<marcelo@plucky.distro.conectiva> (02/03/25 1.278)
	new helper - mount_block_root() (code that goes through the list

<marcelo@plucky.distro.conectiva> (02/03/25 1.279)
	minor cleanups - mount_root() used to be followed by the same code

<marcelo@plucky.distro.conectiva> (02/03/25 1.280)
	branch after the successful initrd_load() taken into a helper

<marcelo@plucky.distro.conectiva> (02/03/25 1.281)
	instead of mounting/umounting devfs on /dev (rootfs one) in

<marcelo@plucky.distro.conectiva> (02/03/25 1.282)
	new helper - create_dev(name, dev, devfs_name).  It either

<marcelo@plucky.distro.conectiva> (02/03/25 1.283)
	change_root() merged into its caller (handle_initrd()).  More

<marcelo@plucky.distro.conectiva> (02/03/25 1.284)
	rd_load() and rd_load_secondary() merged into their resp. callers.

<marcelo@plucky.distro.conectiva> (02/03/25 1.285)
	new helper - mount_nfs_root().  Yup, attempt to mount nfsroot.

<marcelo@plucky.distro.conectiva> (02/03/25 1.286)
	new helper - change_floppy().  Ejects floppy, asks to replace it

<marcelo@plucky.distro.conectiva> (02/03/25 1.287)
	preparation to cleanup of rd_load_image() (actual loading of

<marcelo@plucky.distro.conectiva> (02/03/25 1.288)
	straightforward switch of rd_load_image() to normal syscalls -

<akpm@reardensteel.com> (02/03/25 1.290)
	[PATCH] The inline-BUG patch

<akpm@zip.com.au> (02/03/25 1.291)
	[PATCH] tunable request queue size

<cyeoh@samba.org> (02/03/25 1.292)
	[PATCH] msync writing when MS_INVALIDATE set and memory locked

<davem@nuts.ninka.net> (02/03/25 1.189.1.15)
	QFE interrupts are mapped INTB/INTC/INTD/INTA.

<davem@nuts.ninka.net> (02/03/25 1.189.1.16)
	In Sparc64 PCI IRQ routing, remove QFE special case.

<uzi@uzix.org> (02/03/25 1.189.1.17)
	Sparc32 cleanups.

<rmk@flint.arm.linux.org.uk> (02/03/26 1.294)
	Sync ARM syscall tables.  Also try to get people to stop adding

<davem@nuts.ninka.net> (02/03/26 1.189.1.18)
	Do the slot mapping adjustment to PROM interrupt

<davem@nuts.ninka.net> (02/03/26 1.181.2.38)
	Fix device list locking.

<marcelo@plucky.distro.conectiva> (02/03/26 1.292.1.3)
	Remove asm/proc_fs.h include from fs/proc/root.c

<marcelo@plucky.distro.conectiva> (02/03/26 1.292.1.4)
	Added ppc64 init proc declarations

<marcelo@plucky.distro.conectiva> (02/03/26 1.292.1.5)
	Added ITE_IT8330G PCI ID

<marcelo@plucky.distro.conectiva> (02/03/26 1.292.1.6)
	Added missing ";" to iSeries_proc_create definition

<jaharkes@cs.cmu.edu> (02/03/27 1.292.1.7)
	[PATCH] Coda update for 2.4.19-pre4

<hch@pentafluge.infradead.org> (02/03/27 1.296)
	[PATCH] fix firewire compilation

<mj@ucw.cz> (02/03/27 1.297)
	[PATCH] PATCH: PCI ID's

<adam@nmt.edu> (02/03/27 1.298)
	[PATCH] 3ware driver update for 2.4.19-pre5

<rth@are.twiddle.net> (02/03/28 1.292.2.1)
	Fix single denorm -> double conversion.

<rth@are.twiddle.net> (02/03/28 1.292.2.2)
	Update NR_SYSCALLS.

<akpm@zip.com.au> (02/03/29 1.299)
	Various changes to the dirty buffer flushing code.

<akpm@zip.com.au> (02/03/29 1.300)
	1: Introduces two new bdflush tunables:

<akpm@zip.com.au> (02/03/29 1.302)
	[PATCH] speed up ext2 synchronous mounts

<akpm@zip.com.au> (02/03/29 1.303)
	[PATCH] speed up ext3 synchronous mounts

<arjanv@redhat.com> (02/03/29 1.304)
	[PATCH] more scsi whitelist entries

<dougg@torque.net> (02/03/29 1.305)
	[PATCH] scsi generic (sg) driver, lk 2.4.18

<bcollins@debian.org> (02/03/29 1.306)
	[PATCH] MAINTAINERS update for 1394

<vojtech@suse.cz> (02/03/29 1.307)
	[PATCH] Update the VIA driver to support the vt8233a

<hch@pentafluge.infradead.org> (02/03/29 1.308)
	[PATCH] include compiler.h in kernel.h

<jt@bougret.hpl.hp.com> (02/03/29 1.309)
	[PATCH] New wireless driver API part 1

<marcelo@plucky.distro.conectiva> (02/03/29 1.310)
	Changed EXTRAVERSION to pre5

Summary of changes from v2.4.19-pre3 to v2.4.19-pre4
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.163)
	Update aic7xxx to 6.2.5

<sfr@canb.auug.org.au> (02/03/13 1.164)
	[PATCH] Trivial APM update part 1

<sfr@canb.auug.org.au> (02/03/13 1.165)
	[PATCH] APM patch: change implementation of ALWAYS_CALL_BUSY

<sfr@canb.auug.org.au> (02/03/13 1.166)
	[PATCH] APM patch: apm_cpu_idle cleanups

<jgarzik@mandrakesoft.com> (02/03/13 1.167)
	[PATCH] PATCH: add MWI support to PCI

<jgarzik@mandrakesoft.com> (02/03/13 1.168)
	[PATCH] PATCH: starfire updates

<jgarzik@mandrakesoft.com> (02/03/13 1.169)
	[PATCH] PATCH: tulip use pci_set_mwi

<jgarzik@mandrakesoft.com> (02/03/13 1.170)
	[PATCH] PATCH: starfire use pci_set_mwi

<akpm@zip.com.au> (02/03/14 1.171)
	[PATCH] fix layout of mapped files

<greg@kroah.com> (02/03/14 1.172)
	[PATCH] export IO_APIC_get_PCI_irq_vector for IBM PCI Hotplug driver

<kaos@ocs.com.au> (02/03/14 1.173)
	[PATCH] 2.4.19-pre3 rename duplicate partition_name()

<rml@tech9.net> (02/03/14 1.174)
	[PATCH] more lseek cleanup

<rml@tech9.net> (02/03/14 1.175)
	[PATCH] 2.4: UFS lseek cleanup

<bcrl@redhat.com> (02/03/14 1.176)
	[PATCH] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)

<sfr@canb.auug.org.au> (02/03/14 1.177)
	[PATCH] dnotify

<trond.myklebust@fys.uio.no> (02/03/14 1.178)
	[PATCH] Fix 2.4.19-pre3 NFS client file creation

<trond.myklebust@fys.uio.no> (02/03/14 1.179)
	[PATCH] Fix 2.4.19-pre3 NFS reads from holding a write leases.

<trond.myklebust@fys.uio.no> (02/03/14 1.180)
	[PATCH] 2.4.19-pre3 NFS close-to-open fixes

<trond.myklebust@fys.uio.no> (02/03/14 1.181)
	[PATCH] 2.4.19-pre3 NFS close-to-open fix part 2 (VFS change)

<davem@nuts.ninka.net> (02/03/13 1.182)
	Sparc64 updates and fixes:

<davem@nuts.ninka.net> (02/03/13 1.183)
	Fix unterminated comment in asm-sparc64/ide.h

<marcelo@plucky.distro.conectiva> (02/03/14 1.181.1.1)
	Remove off-by-one Davej's fix in bluesmoke.c: it causes some

<davem@nuts.ninka.net> (02/03/14 1.184)
	Missed this add during sparc64 updates.

<davem@nuts.ninka.net> (02/03/14 1.185)
	Sparc64 build fix: add nop flush_icache_user_range definition.

<davem@nuts.ninka.net> (02/03/14 1.186)
	Kill unused variable warnings in sunlance driver.

<davem@nuts.ninka.net> (02/03/14 1.181.2.1)
	Networking updates and fixes:

<davem@nuts.ninka.net> (02/03/14 1.181.2.2)
	Fix "performance optimization" that breaks the build

<davem@nuts.ninka.net> (02/03/14 1.187)
	Kill unused variable warnings in sunbmac.c and sunqe.c

<davem@nuts.ninka.net> (02/03/14 1.188)
	SunGEM driver updates:

<davem@nuts.ninka.net> (02/03/14 1.189)
	Fix unterminated comment in asm-sparc/ide.h

<davem@nuts.ninka.net> (02/03/14 1.181.2.3)
	New driver for Tigon3 gigabit chipsets, written by

<geert@linux-m68k.org> (02/03/14 1.181.1.2)
	[PATCH] Yearly m68k update (part 41)

<geert@linux-m68k.org> (02/03/14 1.181.1.3)
	[PATCH] Yearly m68k update (part 40)

<geert@linux-m68k.org> (02/03/14 1.181.1.4)
	[PATCH] Yearly m68k update (part 39)

<geert@linux-m68k.org> (02/03/14 1.181.1.5)
	[PATCH] Yearly m68k update (part 36)

<geert@linux-m68k.org> (02/03/14 1.181.1.6)
	[PATCH] Yearly m68k update (part 31)

<geert@linux-m68k.org> (02/03/14 1.181.1.7)
	[PATCH] Yearly m68k update (part 27)

<geert@linux-m68k.org> (02/03/14 1.181.1.8)
	[PATCH] Yearly m68k update (part 35)

<geert@linux-m68k.org> (02/03/14 1.181.1.9)
	[PATCH] Yearly m68k update (part 24)

<geert@linux-m68k.org> (02/03/14 1.181.1.10)
	[PATCH] Yearly m68k update (part 38)

<geert@linux-m68k.org> (02/03/14 1.181.1.11)
	[PATCH] Yearly m68k update (part 28)

<geert@linux-m68k.org> (02/03/14 1.181.1.12)
	[PATCH] Yearly m68k update (part 13)

<geert@linux-m68k.org> (02/03/14 1.181.1.13)
	[PATCH] Yearly m68k update (part 37)

<geert@linux-m68k.org> (02/03/14 1.181.1.14)
	[PATCH] Yearly m68k update (part 7)

<geert@linux-m68k.org> (02/03/14 1.181.1.15)
	[PATCH] Yearly m68k update (part 32)

<geert@linux-m68k.org> (02/03/14 1.181.1.16)
	[PATCH] Yearly m68k update (part 34)

<geert@linux-m68k.org> (02/03/14 1.181.1.17)
	[PATCH] Yearly m68k update (part 25)

<geert@linux-m68k.org> (02/03/14 1.181.1.18)
	[PATCH] Yearly m68k update (part 11)

<geert@linux-m68k.org> (02/03/14 1.181.1.19)
	[PATCH] Yearly m68k update (part 30)

<geert@linux-m68k.org> (02/03/14 1.181.1.20)
	[PATCH] Yearly m68k update (part 6)

<geert@linux-m68k.org> (02/03/14 1.181.1.21)
	[PATCH] Yearly m68k update (part 33)

<geert@linux-m68k.org> (02/03/14 1.181.1.22)
	[PATCH] Yearly m68k update (part 4)

<geert@linux-m68k.org> (02/03/14 1.181.1.23)
	[PATCH] Yearly m68k update (part 2)

<geert@linux-m68k.org> (02/03/14 1.181.1.24)
	[PATCH] Yearly m68k update (part 8)

<geert@linux-m68k.org> (02/03/14 1.181.1.25)
	[PATCH] Yearly m68k update (part 12)

<geert@linux-m68k.org> (02/03/14 1.181.1.26)
	[PATCH] Yearly m68k update (part 16)

<geert@linux-m68k.org> (02/03/14 1.181.1.27)
	[PATCH] Yearly m68k update (part 3)

<geert@linux-m68k.org> (02/03/14 1.181.1.28)
	[PATCH] Yearly m68k update (part 29)

<geert@linux-m68k.org> (02/03/14 1.181.1.29)
	[PATCH] Yearly m68k update (part 19)

<geert@linux-m68k.org> (02/03/14 1.181.1.30)
	[PATCH] Yearly m68k update (part 21)

<geert@linux-m68k.org> (02/03/14 1.181.1.31)
	[PATCH] Yearly m68k update (part 17)

<geert@linux-m68k.org> (02/03/14 1.181.1.32)
	[PATCH] Yearly m68k update (part 5)

<geert@linux-m68k.org> (02/03/14 1.181.1.33)
	[PATCH] Yearly m68k update (part 15)

<geert@linux-m68k.org> (02/03/14 1.181.1.34)
	[PATCH] Yearly m68k update (part 26)

<geert@linux-m68k.org> (02/03/14 1.181.1.35)
	[PATCH] Yearly m68k update (part 22)

<geert@linux-m68k.org> (02/03/14 1.181.1.36)
	[PATCH] Yearly m68k update (part 1)

<geert@linux-m68k.org> (02/03/14 1.181.1.37)
	[PATCH] Yearly m68k update (part 23)

<geert@linux-m68k.org> (02/03/14 1.181.1.38)
	[PATCH] Yearly m68k update (part 9)

<geert@linux-m68k.org> (02/03/14 1.181.1.39)
	[PATCH] Yearly m68k update (part 10)

<geert@linux-m68k.org> (02/03/14 1.181.1.40)
	[PATCH] Yearly m68k update (part 18)

<geert@linux-m68k.org> (02/03/14 1.181.1.41)
	[PATCH] Yearly m68k update (part 20)

<kraxel@bytesex.org> (02/03/14 1.181.1.42)
	[PATCH] v4l: video4linux API doc update

<kraxel@bytesex.org> (02/03/14 1.181.1.43)
	[PATCH] vmalloc_to_page() backport for 2.4

<kraxel@bytesex.org> (02/03/14 1.181.1.44)
	[PATCH] v4l: videodev redesign

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.45)
	[PATCH] ISDN fixes / update

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.46)
	[PATCH] ISDN fixes / update

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.47)
	[PATCH] ISDN fixes / update

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.48)
	[PATCH] ISDN fixes / update

<kai-germaschewski@uiowa.edu> (02/03/14 1.181.1.49)
	[PATCH] ISDN fixes / update

<greg@kroah.com> (02/03/14 1.181.1.50)
	[PATCH] USB Config.in update

<greg@kroah.com> (02/03/14 1.181.1.51)
	[PATCH] USB edgeport driver bugfix

<greg@kroah.com> (02/03/14 1.181.1.52)
	[PATCH] USB usbfs name added

<greg@kroah.com> (02/03/14 1.181.1.53)
	[PATCH] USB ipaq driver bugfix

<greg@kroah.com> (02/03/14 1.181.1.54)
	[PATCH] USB catc ethtool support

<greg@kroah.com> (02/03/14 1.181.1.55)
	[PATCH] USB CREDITS and MAINTAINERS update

<greg@kroah.com> (02/03/14 1.181.1.56)
	[PATCH] USB pegasus ethtool support

<greg@kroah.com> (02/03/14 1.181.1.57)
	[PATCH] USB em26 driver added

<davem@nuts.ninka.net> (02/03/14 1.181.2.4)
	Allow ARP packets to be seen by netfilter.

<kai@tp1.ruhr-uni-bochum.de> (02/03/14 1.181.1.58)
	Put back the option to support AVM A1 / Fritz! PCMCIA cards inside hisax.

<davem@nuts.ninka.net> (02/03/14 1.181.2.5)
	Include linux/netfilter_arp.h

<marcelo@plucky.distro.conectiva> (02/03/14 1.192)
	Add missing aic7xxx updates

<axboe@suse.de> (02/03/14 1.193)
	[PATCH] cciss driver pci_*_consistent(NULL,...) fix for 2.4.19-pre2 (1 of 4)

<axboe@suse.de> (02/03/14 1.194)
	[PATCH] cciss driver GETLUNINFO ioctl (2 of 4)

<axboe@suse.de> (02/03/14 1.195)
	[PATCH] cciss driver HDIO_GETGEO_BIG ioctl for 2.4.19-pre2 (3 of 4)

<axboe@suse.de> (02/03/14 1.196)
	[PATCH] remove CCISS_REVALIDVOLS ioctl for 2.4.19-pre2 (4 of 4)

<marcelo@plucky.distro.conectiva> (02/03/14 1.197)
	The problem is that both the sd and sr drivers treat an

<davem@nuts.ninka.net> (02/03/14 1.181.2.6)
	From Harald Welte and the Netfilter team:

<davem@nuts.ninka.net> (02/03/14 1.181.2.7)
	From Harald Welte and the Netfilter team:

<EdV@macrolink.com> (02/03/15 1.198)
	This patch corrects PCI device id in pci_ids.h for Oxford Semi OX16PCI952

<jgarzik@mandrakesoft.com> (02/03/15 1.199)
	Remove VT8233 pci ids from via82cxxx_audio sound driver.

<nahshon@actcom.co.il> (02/03/15 1.200)
	Fix via audio recording, when frag size < page size.

<silicon@falcon.sch.bme.hu> (02/03/15 1.201)
	Add new slicecom/munich WAN driver.

<hch@caldera.de> (02/03/15 1.197.2.1)
	[PATCH] remove superflous assignment in mmap()

<hch@caldera.de> (02/03/15 1.197.2.2)
	[PATCH] Error return fixes

<hch@caldera.de> (02/03/15 1.197.2.3)
	[PATCH] missing include in net/sunrpc/stats.c

<davem@nuts.ninka.net> (02/03/15 1.181.2.8)
	Add arptables netfilter module for registering ARP

<bfennema@falcon.csc.calpoly.edu> (02/03/15 1.197.2.4)
	Missing byte swaps needed for big endian archs

<mikpe@csd.uu.se> (02/03/15 1.197.2.5)
	[PATCH] boot_cpu_data corruption on SMP x86

<bfennema@falcon.csc.calpoly.edu> (02/03/15 1.197.2.7)
	Fix videodev build warning

<davem@nuts.ninka.net> (02/03/17 1.181.2.9)
	Fix netfilter IPv4 conntrack build.

<marcelo@plucky.distro.conectiva> (02/03/19 1.204)
	Changed EXTRAVERSION in Makefile to pre4

<stelian.pop@fr.alcove.com> (02/03/19 1.205)
	[PATCH] videodev.c oopses in video_exclusive_register

<stelian.pop@fr.alcove.com> (02/03/19 1.206)
	[PATCH] meye driver update to new V4L API.

<rusty@rustcorp.com.au> (02/03/19 1.207)
	[PATCH] 2.4.19-pre3 Trivial I: seq_file.h update

<rusty@rustcorp.com.au> (02/03/19 1.208)
	[PATCH] Trivial I: fs_exec.c core fix

<rusty@rustcorp.com.au> (02/03/19 1.209)
	[PATCH] 2.4.19-pre3 Trivial III: -ENOTTY for nvram

<rusty@rustcorp.com.au> (02/03/19 1.210)
	[PATCH] 2.4.19-pre3 Trivial IV: -ENOTTY

<rusty@rustcorp.com.au> (02/03/19 1.211)
	[PATCH] 2.4.19-pre3 Trivial VI: MSDOS options

<marcelo@plucky.distro.conectiva> (02/03/19 1.212)
	If setup_arg_pages() fails, we continue

<rmk@arm.linux.org.uk> (02/03/19 1.213)
	[PATCH] 2.4 and 2.5: remove Alt-Sysrq-L

<rmk@arm.linux.org.uk> (02/03/19 1.214)
	[PATCH] 2.5 and 2.4: fix PCI IO BAR flags

<marcelo@plucky.distro.conectiva> (02/03/19 1.215)
	Remove unused videodev_register_lock

<marcelo@plucky.distro.conectiva> (02/03/19 1.216)
	Avoid page_to_phys() from truncating the physical addresses to 32bit,

<hch@caldera.de> (02/03/19 1.217)
	[PATCH] fix Config.in breakage

<hch@caldera.de> (02/03/19 1.218)
	[PATCH] kill slow-path micro-optimization

<hch@caldera.de> (02/03/19 1.219)
	[PATCH] export rbtree routines

<paulus@samba.org> (02/03/19 1.220)
	[PATCH] Re: [PATCH] zlib double-free bug

<trond.myklebust@fys.uio.no> (02/03/20 1.220.3.2)
	[PATCH] Fix bug in sunrpc code...

Summary of changes from v2.4.19-pre2 to v2.4.19-pre3
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.162)
	- -ac merge (including new IDE)                         (Alan Cox)
	- S390 merge                                            (IBM)
	- More cciss fixes                                      (Stephen Cameron)
	- Eicon SMP race fix                                    (Armin Schindler)
	- w9966 driver update                                   (Jakob Kemi)
	- Unify crc32 routine (removes lots of duplicated
	  code from drivers)                                    (Matt Domsch)
	- Lanstreamer bugfixes                                  (Kent Yoder)
	- Update scsi_debug                                     (Douglas Gilbert)
	- MCE Configure.help update                             (Paul Gortmaker)
	- Fix SMB NLS oops                                      (Urban Widmark)
	- AGP Config.in update                                  (Daniele Venzano)
	- Fix small thinko in UFS set_blocksize return handling (me)
	- Avoid unecessary cache flushes on PPC                 (Paul Mackerras)
	- PPP deadlock fixes                                    (Paul Mackerras)
	- Signal changes for thread groups                      (Dave McCracken)
	- Make max_threads be based on normal zone size         (Dave McCracken)
	- ray_cs wireless extension fix                         (Jean Tourrilhes)
	- irda bugfixes and enhancements                        (Jean Tourrilhes)
	- USB update                                            (Greg KH)
	- Fix through-8259A mode for IRQ0 routing on APIC       (Maciej W. Rozycki/Joe Korty)
	- Add Dell Inspiron 2500 to broken APM blacklist        (Arjan van de Ven)
	- Fix off-by-one error in bluesmoke                     (Dave Jones)
	- Reiserfs update                                       (Oleg Drokin)
	- Fix PCI compile without /proc support                 (Eric Sandeen)
	- Fix problem with bad inode handling                   (Alexander Viro)
	- aic7xxx update                                        (Justin T. Gibbs)
	- Do not consider SCSI recovered errors as fatal errors (Justin T. Gibbs)
	- Add Memory-Write-Invalidate support to PCI            (Jeff Garzik)
	- Starfire update                                       (Ion Badulescu)
	- tulip update                                          (Jeff Garzik)


Summary of changes from v2.4.19-pre1 to v2.4.19-pre2
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.161)
	- -ac merge                                             (Alan Cox)
	- Huge MIPS/MIPS64 merge                                (Ralf Baechle)
	- IA64 update                                           (David Mosberger)
	- PPC update                                            (Tom Rini)
	- Shrink struct page                                    (Rik van Riel)
	- QNX4 update (now its able to mount QNX 6.1 fses)      (Anders Larsen)
	- Make max_map_count sysctl configurable                (Christoph Hellwig)
	- matroxfb update                                       (Petr Vandrovec)
	- ymfpci update                                         (Pete Zaitcev)
	- LVM update                                            (Heinz J . Mauelshagen)
	- btaudio driver update                                 (Gerd Knorr)
	- bttv update                                           (Gerd Knorr)
	- Out of line code cleanup                              (Keith Owens)
	- Add watchdog API documentation                        (Christer Weinigel)
	- Rivafb update                                         (Ani Joshi)
	- Enable PCI buses above quad0 on NUMA-Q                (Martin J. Bligh)
	- Fix PIIX IDE slave PCI timings                        (Dave Bogdanoff)
	- Make PLIP work again                                  (Tim Waugh)
	- Remove unecessary printk from lp.c                    (Tim Waugh)
	- Make parport_daisy_select work for ECP/EPP modes      (Max Vorobiev)
	- Support O_NONBLOCK on lp/ppdev correctly              (Tim Waugh)
	- Add PCI card hooks to parport                         (Tim Waugh)
	- Compaq cciss driver fixes                             (Stephen Cameron)
	- VFS cleanups and fixes                                (Alexander Viro)
	- USB update (including USB 2.0 support)                (Greg KH)
	- More jiffies compare cleanups                         (Tim Schmielau)
	- PCI hotplug update                                    (Greg KH)
	- bluesmoke fixes                                       (Dave Jones)
	- Fix off-by-one in ide-scsi                            (John Fremlin)
	- Fix warnings in make xconfig                          (Ren� Scharfe)
	- Make x86 MCE a configure option                       (Paul Gortmaker)
	- Small ramdisk fixes                                   (Christoph Hellwig)
	- Add missing atime update to pipe code                 (Christoph Hellwig)
	- Serialize microcode access                            (Tigran Aivazian)
	- AMD Elan handling on serial.c                         (Robert Schwebel)


Summary of changes from v2.4.18 to v2.4.19-pre1
============================================

<marcelo@plucky.distro.conectiva> (02/03/13 1.160)
	- Add tape support to cciss driver                      (Stephen Cameron)
	- Add Permedia3 fb driver                               (Romain Dolbeau)
	- meye driver update                                    (Stelian Pop)
	- opl3sa2 update                                        (Zwane Mwaikambo)
	- JFFS2 update                                          (David Woodhouse)
	- NBD deadlock fix                                      (Steven Whitehouse)
	- Correct sys_shmdt() return value on failure           (Adam Bottchen)
	- Apply the SET_PERSONALITY patch missing from 2.4.18   (me)
	- Alpha update                                          (Jay Estabrook)
	- SPARC64 update                                        (David S. Miller)
	- Fix potential blk freelist corruption                 (Jens Axboe)
	- Fix potential hpfs oops                               (Chris Mason)
	- get_request() starvation fix                          (Andrew Morton)
	- cramfs update                                         (Daniel Quinlan)
	- Allow binfmt_elf as module                            (Paul Gortmaker)
	- ymfpci Configure.help update                          (Pete Zaitcev)
	- Backout one eepro100 change made in 2.4.18: it
	  was causing slowdowns on some cards                   (Jeff Garzik)
	- Tridentfb compilation fix                             (Jani Monoses)
	- Fix refcounting of directories on renames in tmpfs    (Christoph Rohland)
	- Add Fujitsu notebook to broken APM implementation
	  blacklist                                             (Arjan Van de Ven)
	- "do { ... } while(0)" cleanups on some fb drivers     (Geert Uytterhoeven)
	- Fix natsemi's ETHTOOL_GLINK ioctl                     (Tim Hockin)
	- Fix clik! drive detection code in ide-floppy          (Paul Bristow)
	- Add additional support for the 82801 I/O controller   (Wim Van Sebroeck)
	- Remove duplicates in pci_ids.h                        (Wim Van Sebroeck)


