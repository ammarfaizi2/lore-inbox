Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTIQFcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbTIQFcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:32:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:43468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262577AbTIQFcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:32:02 -0400
Date: Tue, 16 Sep 2003 22:29:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kernel-janitors@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.0-test5-kj2 patchset
Message-Id: <20030916222920.209ba70b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.0-test5-kj2/patch-2.6.0-test5-kj2.bz2  [2003-09-16]

This is an update to patch-2.6.0-test5-kj1.
This patchset is against plain 2.5.0-test5.


changes since patch-2.6.0-test4-bk4-kj1:  [2003-09-02]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/	update EXTRAVERSION: add -kj1  (OOPS: NOT UPDATED !!!)
/

rediff/	scsi_sg_register.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	printk KERN_* constants in Documentation/
	"Warren A. Layton" <zeevon@debian.org>

keep/	devfs_cdev_misc_reg.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_av7110_retval.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_budget_2.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_budget_retval.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_budget_ci_retval.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	dvb_ttusb_copyuser.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	opl3sa2_cleanups.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

keep/	sound_use_strsep.patch
	From: maximilian attems <janitor@sternwelten.at>

add/	char_dz_verify.patch
	From: Domen Puncer <domen@coderock.org>
drop/	for serial rewrite;

add/	char_riolinux_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	char_sx_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	coda_upcall_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	h8300_ptrace_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	input_init_procfs2.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	input_noprocfs.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	isdn_common_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	isdn_hisax_isar_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	net_bluetooth_hcicore_verify.patch
	From: Domen Puncer <domen@coderock.org>

drop/	net_ipv4_route_noproc.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
already merged (Dave Jones)

add/	net_ns83820_err_handling.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

add/	net_rcpci_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

???	net_wan_sbni_verify.patch
	From: Domen Puncer <domen@coderock.org>
!patch failure!

add/	net_wireless_orinoco_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	ppc_syscalls_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	s390_net_ctctty_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap

add/	sbus_jsflash_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap

add/	serial_68328_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap

add/	serial_mcfserial_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	serial_tx3912_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	SMP_removal_last.patch
	From: Adrian Bunk <bunk@fs.tum.de>

add/	sound_cmipci_procfs2.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>

add	version-patches-b.tar.bz2
/	version_drivers_media_video.patch
/	version_drivers_pnp_isapnp.patch
/	version_drivers_scsi.patch
/	version_drivers_telephony.patch
/	version_drivers_video.patch
/	version_net.patch
/	version_net_sched.patch
/	version_net_wanrouter.patch
/	version_sk98lin.patch
/	version_skfp.patch
/	version_sound_drivers.patch
/	version_sound_oss.patch
/	version_wireless.patch
	From: Randy Hron <rwhron@earthlink.net>

add:	rh_version2.tar.bz2
/	drivers_net_wan.patch
/	drivers_net_hamradio.patch
/	drivers_net_tokenring.patch
	From: Randy Hron <rwhron@earthlink.net>

add/	drivers_media_version.patch
/	drivers_isdn_version.patch
/	drivers_char_version.patch
/	fs_intermezzo_includes.patch
	From: Randy Hron <rwhron@earthlink.net>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New for -kj2:

/	char_toshiba_noprocfs.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
drop/	changes behavior in a bad way;

add/	printk_newlines.patch
	From: maximilian attems <janitor@sternwelten.at>

add:	version3.tar.bz2
	version4.tar.bz2
/	version_drivers_mtd.patch
/	version_drivers_pcmcia.patch
/	version_drivers_s390.patch
/	version_drivers_usb.patch
WT	version_oss_dmasound.patch (needs 260-test5-bk3)
/	version_sbus_char.patch
/	version_drivers_cdrom.patch
	From: Randy Hron <rwhron@earthlink.net>

###



--
~Randy
