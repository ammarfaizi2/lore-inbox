Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270656AbTHADmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 23:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270657AbTHADmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 23:42:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:46764 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270656AbTHADmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 23:42:25 -0400
Message-ID: <32989.4.4.25.4.1059709343.squirrel@www.osdl.org>
Date: Thu, 31 Jul 2003 20:42:23 -0700 (PDT)
Subject: [announce] patch-2.6.0-test2-kj1
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <kernel-janitor-discuss@lists.sourceforge.net>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.0-test2/patch-2.6.0-test2-kj1.bz2

changes since patch-2.5.74-kj1:  [for 2.6.0-test2-kj1, 2003-07-31]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

add/	update EXTRAVERSION: add -kj1

drop/	audit copy_from_user and fixed memory leak in drivers/net/comx-hw-comx.c
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	Audit copy_from_user in drivers/parisc/led.c
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	Audit copy_from_user in drivers/ieee1394/amdtp.c
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	Audit + cleanup in drivers/sbus/char/envctrl.c
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	Audit copy_to_user/put_user in fs/umsdos/ioctl.c
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	audit copy_to_user in net/wireless/ray_cs.c
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	net/irda/vlsi_ir.c copy_from_user audit
	Daniele Bellucci <bellucda@tiscali.it> and
	Matthew Wilcox <willy@debian.org>
	merged in 2.6.0-test2;

drop/	media/video/pms.c copy_from_user audit
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	Netwinder wdt977 misc_register audit
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	teleph_ixj3.patch: audit+cleanup+cod. style
	Daniele Bellucci <bellucda@tiscali.it>
	merged in 2.6.0-test2;

drop/	unchkd_return_copy_from_user_net_core_pktgen.patch
	Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
	merged in 2.6.0-test2;

keep/	pci_name_diff.patch (partial; some already merged; emu10k1 failed)
	"Warren A. Layton" <zeevon@debian.org>

keep/	printk KERN_* constants in Documentation/
	"Warren A. Layton" <zeevon@debian.org>

keep/	KERN_* constants in all printk calls in arch/m68knommu:
	"Warren A. Layton" <zeevon@debian.org>

keep/	uninit_static_misc.patch
	uninit_static_fs.patch
	uninit_static_net.patch
	Leann Ogasawara

add/	arch_arm26_lib_kbd.patch
	Leann Ogasawara

add/	locomx_copy_user.patch
	Daniele Bellucci         <bellucda@tiscali.it>

add/	comx_munich_copy_user.patch
	Daniele Bellucci         <bellucda@tiscali.it>

add/	comx_fr_copy_user.patch
	Daniele Bellucci         <bellucda@tiscali.it>

add/	video_planb_locking.patch
	Domen Puncer <root@coderock.org>

add/	scsi_gdth_ioctl.patch
	Daniele Bellucci <bellucda@tiscali.it>

add/	printk_KERN_arch_sparc.patch
	From: "Warren A. Layton" <zeevon@debian.org>

add/	joydump_locking.patch
	Domen Puncer <root@coderock.org>

add/	drivers_add_license.patch
	dan carpenter <error27@email.com>

add/	char_rtc_cleanup.patch
	Daniele Bellucci <bellucda@tiscali.it>

add/	floppy_blkdev.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

add/	iounmap_typo.patch
	Leann Ogasawara

add/	net_tun_cleanup.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

add/	serio_static.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

add/	string_form3.patch
	From: maximilian attems <janitor@sternwelten.at>

add/	sys_bin_copy_user.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

add/	dvb_core_reg_dev.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

###



