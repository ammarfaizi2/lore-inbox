Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVDDJVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVDDJVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVDDJVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:21:31 -0400
Received: from fysh.org ([83.170.75.51]:26860 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S261187AbVDDJU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:20:26 -0400
Date: Mon, 4 Apr 2005 10:20:25 +0100
From: Athanasius <link@miggy.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Fyshy Admin <root@fysh.org>
Subject: [marcelo@hera.kernel.org: linux-2.4.30 released]
Message-ID: <20050404092025.GF25576@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Fyshy Admin <root@fysh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LKTjZJSUETSlgu2t"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LKTjZJSUETSlgu2t
Content-Type: multipart/mixed; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Nothing in the changelog for this is screaming "patch now!!!" at me,
but it would probably be best to update.

  I'll see if I can sort out compiling it up as usual (unpack in
/usr/local/src/kernel, tar.bz2 in /usr/local/dist/Kernel), but anyone
else with the time feel free.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--MnLPg7ZWsaic7Fhd
Content-Type: message/rfc822
Content-Disposition: inline


Envelope-to: link@miggy.org
Received: from vger.kernel.org [12.107.209.244] 
	by bowl.fysh.org with esmtp (Exim 3.35 #1 (Debian))
	id 1DIGh2-0006F5-00
	for <link@miggy.org>; Mon, 04 Apr 2005 02:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVDDBpz (ORCPT <rfc822;link@miggy.org>);
	Sun, 3 Apr 2005 21:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVDDBpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 21:45:55 -0400
Received: from hera.kernel.org ([209.128.68.125]:11754 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261963AbVDDBob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 21:44:31 -0400
Received: from hera.kernel.org (localhost [127.0.0.1])
	by hera.kernel.org (8.12.11/8.12.8) with ESMTP id j341iOde005250
	for <linux-kernel@vger.kernel.org>; Sun, 3 Apr 2005 18:44:24 -0700
Received: (from marcelo@localhost)
	by hera.kernel.org (8.12.11/8.12.11/Submit) id j341iO2o005247;
	Sun, 3 Apr 2005 18:44:24 -0700
Date:	Sun, 3 Apr 2005 18:44:24 -0700
From:	Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200504040144.j341iO2o005247@hera.kernel.org>
To:	linux-kernel@vger.kernel.org
Subject: linux-2.4.30 released
X-Spam-Status: No, hits=-5.2 required=5.0
	tests=BAYES_00
	version=2.55
X-Spam-Checker-Version:	SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.6

final:

- 2.4.30-rc4 was released as 2.4.30 with no changes.



Summary of changes from v2.4.30-rc3 to v2.4.30-rc4
============================================

Herbert Xu:
  o [NETLINK] Fix bogus mc_list deletion

Marcelo Tosatti:
  o Cset exclude: hifumi.hisashi@lab.ntt.co.jp|ChangeSet|20050226095914|25750
  o Change VERSION to 2.4.30-rc4

Willy Tarreau:
  o Keith Owens: modutils >= 2.4.14 is required for MODVERSIONS+EXPORT_SYMBOL_GPL() combination


Summary of changes from v2.4.30-rc2 to v2.4.30-rc3
============================================

Marcelo Tosatti:
  o Andreas Arens: Fix deadly mismerge of binfmt_elf DoS fix
  o Change VERSION to 2.4.30-rc3


Summary of changes from v2.4.30-rc1 to v2.4.30-rc2
============================================

<davem:sunset.davemloft.net>:
  o [TG3]: Add missing CHIPREV_5750_{A,B}X defines
  o [TG3]: Missing counter bump in tigon3_4gb_hwbug_workaround()
  o [TG3]: Update driver version and reldate

<magnus.damm:gmail.com>:
  o eepro100: fix module parameter description typo

<mlafon:arkoon.net>:
  o CAN-2005-0400: ext2 mkdir() directory entry random kernel memory leak

<relf:os2.ru>:
  o fs/hpfs/*: fix HPFS support under 64-bit kernel

<sj-netfilter:cookinglinux.org>:
  o [NETFILTER]: Fix another DECLARE_MUTEX in header file

Bjorn Helgaas:
  o ia64: force all kernel sections into one and the same segment
  o ia64: round iommu allocations to power-of-two sizes
  o ia64: fix perfmon typo in /proc/pal/CPU*/processor_info w.r.t. BERR
  o ia64: add missing syscall-slot
  o ia64: Update defconfigs

Chris Wright:
  o isofs: Some more defensive checks to keep corrupt isofs images from corrupting memory/oopsing

Dave Kleikamp:
  o JFS: remove aops from directory inodes

David Mosberger:
  o Fix pte_modify() bug which allowed mprotect() to change too many bits
  o ia64: Fix _PAGE_CHG_MASK so PROT_NONE works again.  Caught by Linus

Greg Banks:
  o link_path_walk refcount problem allows umount of active filesystem

Herbert Xu:
  o [CRYPTO]: Mark myself as co-maintainer
  o [NETLINK]: Fix multicast bind/autobind race
  o CAN-2005-0794: Potential DOS in load_elf_library

Keith Owens:
  o [IA64] Sanity check unw_unwind_to_user
  o [IA64] Tighten up unw_unwind_to_user check

Linus Torvalds:
  o isofs: Handle corupted rock-ridge info slightly better
  o isofs: more "corrupted iso image" error cases

Marcel Holtmann:
  o CAN-2005-0750: Fix af_bluetooth range checking bug, discovered by Ilja van Sprundel <ilja@suresec.org>

Marcelo Tosatti:
  o Change VERSION to 2.4.30-rc2

Michael Chan:
  o [TG3]: Add 5705_plus flag
  o [TG3]: Flush status block in tg3_interrupt()
  o [TG3]: Add unstable PLL workaround for 5750
  o [TG3]: Fix jumbo frames phy settings
  o [TG3]: Fix ethtool set functions
  o [TG3]: Add Broadcom copyright

Neil Brown:
  o nlm: fix f_count leak
  o [PATCH md: allow degraded raid1 array to resync after an unclean shutdown

Pablo Neira:
  o [NETFILTER]: Fix DECLARE_MUTEX in header file

Patrick McHardy:
  o [NETFILTER]: fix return values of ipt_recent checkentry
  o [NETFILTER]: Fix ip_ct_selective_cleanup(), and rename ip_ct_iterate_cleanup()
  o [NETFILTER]: Fix cleanup in ipt_recent
  o [NETFILTER]: Fix ip6tables ESP matching with "-p all"
  o [NETFILTER]: Fix refreshing of overlapping expectations
  o [NETFILTER]: Fix IP/TCP option logging
  o [TUN]: Fix check for underflow

Pete Zaitcev:
  o USB: fix oops in serial_write
  o USB: Fix baud selection in mct_u232

Simon Horman:
  o [IPVS]: Fix comment typos
  o Backport v2.6 ATM copy-to-user signedness fix
  o earlyquirk.o is needed for CONFIG_ACPI_BOOT

Stephen Hemminger:
  o [TCP]: BIC not binary searching correctly

Wensong Zhang:
  o [IPVS]: Update mark->cw in the WRR scheduler while service is updated

Yanmin Zhang:
  o [IA64] clean up ptrace corner cases



Summary of changes from v2.4.30-pre3 to v2.4.30-rc1
============================================

<crn:netunix.com>:
  o [SPARC32]: Fix build dependencies for vmlinux.o
  o [SPARC32]: Fix sun4d sbus and current handling
  o [SPARC32]: sun4d needs ZS_WSYNC() zilog reg flushing too

<davem:northbeach.davemloft.net.davemloft.net>:
  o [SPARC64]: Fix semtimedop compat ipc code

<jacques_basson:myrealbox.com>:
  o Fix softdog no reboot on unexpected close

Alan Hourihane:
  o agpgart Intel i915GM ID's and tweaks

Andrea Arcangeli:
  o Write throttling should not take free highmem into account

Chris Wedgwood:
  o early boot code references check_acpi_pci()

Linus Torvalds:
  o Workaround possible pty line discipline race

Marcelo Tosatti:
  o Andrea Arcangeli: get_user_pages() shall not grab PG_reserved pages
  o Paul Mackerras: Remote Linux DoS on ppp servers (CAN-2005-0384)
  o Change VERSION to 2.4.30-rc1

Roland McGrath:
  o i386/x86_64 fpu: fix x87 tag word simulation using fxsave

Solar Designer:
  o Enable gcc warnings for vsprintf/vsnprintf with "format" attribute

Stephen Hemminger:
  o TCP BIC not binary searching correctly

Willy Tarreau:
  o acpi.h needs <linux/init.h>


Summary of changes from v2.4.30-pre2 to v2.4.30-pre3
============================================

<davem:northbeach.davemloft.net.davemloft.net>:
  o [SPARC64]: Tomatillo PCI controller bug fixes
  o [TIGON3]: Do not touch NIC_SRAM_FIRMWARE_MBOX when TG3_FLG2_SUN_570X
  o [TIGON3]: Update driver version and reldate

<hifumi.hisashi:lab.ntt.co.jp>:
  o BUG on error handlings in Ext3 under I/O

<krzysztof.h1:wp.pl>:
  o [SPARC]: DBRI fixes and improvements

<liml:rtr.ca>:
  o sata_qstor: eh_timeout fix

<mallikarjuna.chilakala:intel.com>:
  o e1000: 1 Robert Olsson's fix and
  o e1000: 2 use netif_poll_{enable|disable}
  o e1000: Avoid race between e1000_watchdog
  o e1000: Delay clean-up of last Tx buffer
  o e1000: Fix WOL settings in 82544 based
  o e1000: Patch from Peter Kjellstroem --
  o e1000: Checks for desc ring/rx data
  o e1000: Report failure code when loopback
  o e1000: Fixes related to Cable length
  o e1000: Driver version white space,

<mat.loikkanen:synopsys.com>:
  o [libata] add ->bmdma_{stop,status} hooks

<phil:fifi.org>:
  o sk98lin workaround Asus K8V SE Deluxe buggy firmware

<slee:netengine1.com>:
  o Fix units/partition count in sd.c

Adrian Bunk:
  o drivers/scsi/sata_*: make code static

David S. Miller:
  o [SPARC64]: Fix 32bit compat layer bugs in sys_ipc() and sys_rt_sigtimedwait()
  o [AF_UNIX]: Fix SIOCINQ for STREAM
  o [SPARC64]: Accept 'm5823' clock chip as seen on SB1500

Jeff Garzik:
  o [libata sata_via] minor cleanups
  o [libata sata_via] add support for VT6421 SATA
  o [libata] resync with 2.6 msleep() updates
  o [libata] trivial: whitespace sync with 2.6
  o [libata] do not call pci_disable_device() for certain errors
  o [libata] Add missing hooks, to avoid oops in advanced SATA drivers
  o [libata] Use DMA_{32,64}BIT_MASK in ahci, sata_vsc drivers
  o [libata ahci] Print out port id on error messages
  o [libata] remove_one helper cleanup

John W. Linville:
  o libata: fix command queue leak when xlat_func fails
  o tulip: make tulip_stop_rxtx() wait for DMA to fully stop

Marcelo Tosatti:
  o Cset exclude: solar@openwall.com|ChangeSet|20041125155150|65356
  o Allow lseek on SCSI tapes
  o Allow lseek on osst to keep tar --verify happy
  o Change VERSION to 2.4.30-pre3
  o Early ACPI PCI quirk depends on CONFIG_X86_IO_APIC

Mark Lord:
  o sata_qstor: new basic driver for Pacific Digital
  o [libata qstor] minor update per LKML comments

Matt Domsch:
  o aic7xxx: don't reset chip on pause

Mikael Pettersson:
  o fix undefined behaviour in cistpl.c

Paul Fulghum:
  o fix synclinkmp register access typo

Solar Designer:
  o Fix for swapoff after re-creating device files
  o Fix proc_tty.c comment typos

Zwane Mwaikambo:
  o Fix timer override on nforce



Summary of changes from v2.4.30-pre1 to v2.4.30-pre2
============================================

<krzysztof.h1:wp.pl>:
  o [SPARC32]: Need to clear PSR_EF in psr of childregs on fork() on SMP

<marcelo:dmt.cnet>:
  o Changed VERSION to v2.4.30-pre2

<temnota+kernel:kmv.ru>:
  o megaraid2 reorder inline functions

<vvs:sw.ru>:
  o megaraid2 update 2.10.8.2

Charles-Edouard Ruault:
  o Reserve only needed regions for PC timers on i386 and x86_64

Dave Kleikamp:
  o JFS: remove invalid NULL assignments to i_sb
  o JFS: fix livelock waiting for stale metapage
  o JFS: mount option iocharset=none
  o JFS: change project url to http://jfs.sourceforge.net/

David S. Miller:
  o [SPARC]: Fix bogus trailing semicolon in smb_*() macros
  o [SPARC]: nop() macro has bogus trailing semicolon
  o [TG3]: Update driver version and reldate
  o [SPARC64]: Fix trailing semicolon in membar macros
  o [COMPAT]: TUNSETIFF needs to copy back data after ioctl
  o [TG3]: Always check tg3_readphy() return value
  o [TG3]: Update driver version and reldate
  o [BRLOCKS]: Delete atomic version, is buggy and deadlock prone

Domen Puncer:
  o JFS: delete unused file

Eugene Surovegin:
  o 2.4: fix bogus 440GX rev.C PVR

Hideaki Yoshifuji:
  o [NET]: Fix kernel oops if base_reachable_time is set to 0

Jean Tourrilhes:
  o [NET]: Backport SIOCSIFNAME wildcarding support from 2.6.x

Kenneth Sumrall:
  o Kenneth Sumrall: In lp_write(), copy_from_user() is called to copy data into a statically allocated kernel buffer before down_interruptible()

Michael Chan:
  o [TG3]: capacitive coupling detection fix

Patrick McHardy:
  o [PKT_SCHED]: Fix u32 double listing
  o [NETLINK]: Unhash sockets correctly

Pete Zaitcev:
  o USB: ftdi_sio
  o USB: hid for ia64
  o USB: fix modem_run
  o USB: mct_u232

Stephen Hemminger:
  o [TCP]: Fix BIC max_cwnd calculation error

Stephen Rothwell:
  o PPC64: 32 bit sys_recvmsg corruption
  o Fixup 32 bit sys_recvmsg corruption patch

Thomas Graf:
  o [TCP]: Fix calculation for collapsed skb size


Summary of changes from v2.4.29 to v2.4.30-pre1
============================================

<akeptner:sgi.com>:
  o [TG3]: Always copy receive packets when 5701 PCIX workaround enabled

<albertcc:tw.ibm.com>:
  o [libata] SCSI-to-ATA translation fixes

<fli:ati.com>:
  o [libata sata_sil] support ATI IXP300/IXP400 SATA

<james4765:cwazy.co.uk>:
  o lcd: Add checks to CAP_SYS_ADMIN to potentially dangerous ioctl's
  o lcd: fix memory leak in lcd_ioctl()

<jason.d.gaston:intel.com>:
  o SATA AHCI support for Intel ICH7R

<jpaana:s2.org>:
  o [libata sata_promise] add PCI ID for new SATAII TX2 card

<krzysztof.h1:wp.pl>:
  o [SPARC]: Fix asm constraints in muldiv.c

<mark.haigh:spirentcom.com>:
  o sym53c8xx.c: Add ULL suffix to fix warning
  o arch/i386/kernel/pci-irq.c: Wrong message output

<mkrikis:yahoo.com>:
  o fix an oops in ata_to_sense_error
  o libata: fix ata_piix on ICH6R in RAID mode

<npollitt:mvista.com>:
  o Configure mangles hex values

<syntax:pa.net>:
  o [libata sata_sil] add another Seagate drive to blacklist

Adrian Bunk:
  o scsi/ahci.c: remove an unused function

Andrew Chew:
  o sata_nv: enable generic class support for future NVIDIA SATA

Brett Russ:
  o [libata scsi] verify cmd bug fixes/support

Chris Wright:
  o Fix potential leak of kernel data to user space in wireless private handler helper

David S. Miller:
  o [TG3]: Update driver version and reldate
  o [TG3]: Update driver version and reldate
  o [TG3]: Update driver version and reldate
  o [TG3]: Update driver version and reldate
  o [SPARC64]: __atomic_{add,sub}() must sign-extend return value
  o [TG3]: Update driver version and reldate
  o [SPARC64]: atomic and bitop fixes
  o [SPARC64]: Add missing membars for xchg() and cmpxchg()
  o [SPARC64]: Add missing membars for xchg() and cmpxchg()
  o [SPARC64]: Mask off stack ptr in alloc_user_space() for 32-bit
  o [TG3]: Update driver version and reldate

Ernie Petrides:
  o fix for memory corruption from /proc/kcore access

Grant Grundler:
  o [TG3]: Clean up grc_local_ctrl usage

Haroldo Gamal:
  o [libata sata_sil] add another Seagate driver to blacklist

Heinz J. Mauelshagen:
  o fix panics while backing up LVM snapshots

Herbert Xu:
  o [NET]: Add missing memory barrier to kfree_skb()
  o [NET]: Add barriers for dst refcnt

Jean Delvare:
  o PCI: Kill duplicate definition of INTEL_82801DB_10
  o I2C updates: The "bit" and "pcf" i2c algorithms should declare themselves fully I2C capable
  o I2C updates: small header cleanups
  o I2C updates: Document that the "id" member of the i2c_client structure was discarded in Linux 2.6

Jeff Garzik:
  o [libata] add DMA blacklist
  o [libata] Remove CDROM drive from PATA DMA blacklist
  o [libata sata_promise] support Promise SATAII TX2/TX4 cards
  o [libata ahci] Add support for ULi M5288

Len Brown:
  o [ACPI] via interrupt quirk fix from 2.6 http://bugzilla.kernel.org/show_bug.cgi?id=3319

Luca Tettamanti:
  o Fix MSF overflow in ide-cd with multisession DVDs

Marcelo Tosatti:
  o Karsten Keil: Eicon Diva PCI 2.02 bugfix
  o Cset exclude: temnota@kmv.ru|ChangeSet|20050119161632|63236
  o Ake Sandgren: Fix RLIMIT_RSS madvise calculation bug
  o Cset exclude: dan@embeddedalley.com|ChangeSet|20050128083257|00819
  o Hugh Dickins: remove rlim_rss and this RLIMIT_RSS code from madvise. Presumably the code crept in by mistake
  o Changed VERSION to 2.4.30-pre1
  o Linus Torvalds: backport 2.6 rw_verify_area() to check against file offset overflows
  o Linus Torvalds: Add extra debugging help for bad user accesses
  o Solar Designer: missing f_maxcount initialization
  o Cset exclude: Mark.Haigh@spirentcom.com|ChangeSet|20050203152306|59941
  o rw_verify_area() cleanup
  o Cset exclude: alanh@fairlite.demon.co.uk|ChangeSet|20050209150113|54411

Matthew Wilcox:
  o [IPV4]: ipconfig should use memmove() instead of strcpy()

Michael Chan:
  o [TG3]: add tg3_set_eeprom()
  o [TG3]: Fix TSO for 5750
  o [TG3]: 5750 fixes
  o [TG3]: 5704 serdes fixes

Michal Ostrowski:
  o [MAINTAINERS]: Fix my email address in PPPOE entry

Patrick McHardy:
  o [IPV4]: Keep fragment queues private to each user
  o [NETFILTER]: Fix ip_fw_compat.c build after IP_DEFRAG_* changes

Paul Clements:
  o nbd: fix ioctl permissions

Pete Zaitcev:
  o USB: Prevent hiddev from looping
  o USB: Workarounds for Genesys Logics
  o [libata] fix probe object allocation bugs

Rogier Wolff:
  o Rogier Wolff: fix nbd ioctl permissions

Stephen Hemminger:
  o [PKT_SCHED]: netem: memory leak

Thomas Graf:
  o [NET]: Set NLM_F_MULTI for neighbour rtnetlink messages to userspace
  o [PKT_SCHED]: Fix ingress qdisc to pick up IPv6 packets when using netfilter hooks
  o [NETLINK]: Use SKB_MAXORDER to calculate NLMSG_GOODSIZE

Tom Rini:
  o ppc32: Fix a problem with the TLB Miss handler

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--MnLPg7ZWsaic7Fhd--

--LKTjZJSUETSlgu2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAkJRBtkACgkQIr2uvLNOS8OTcgCcDgI2na+FutlKAEbz/zyCaEbh
JpYAnRu3U+2pFtdZAs4OcWZimTcGDwNd
=1XyW
-----END PGP SIGNATURE-----

--LKTjZJSUETSlgu2t--
