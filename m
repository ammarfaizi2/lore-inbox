Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTI3EP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 00:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTI3EP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 00:15:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:37038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263101AbTI3EPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 00:15:13 -0400
Date: Mon, 29 Sep 2003 21:14:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.0-test6-kj1 patchset
Message-Id: <20030929211423.16f677c8.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.0-test6/patch-2.6.0-test6-kj1.bz2  [2003-09-29]

This patch applies to linux-2.6.0-test6.

changes since patch-2.6.0-test5-bk12-kj3:  [2003-09-25]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/	update EXTRAVERSION: add -kj1
/

keep/	printk KERN_* constants in Documentation/
	"Warren A. Layton" <zeevon@debian.org>

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

add/	ppc_syscalls_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX to paulus@samba.org, benh@kernel.crashing.org: 2003.0925;

add/	sound_cmipci_procfs2.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	version_drivers_media_video.patch
TX to LT: 2003.0917;
add/	version_sound_oss.patch
TX to LT/perex: 2003.0917;
add/	version_drivers_telephony.patch
TX to LT: 2003.0917;
add/	version_drivers_video.patch
TX to LT/maints: 2003.0917;
	From: Randy Hron <rwhron@earthlink.net>

add/	drivers_media_version.patch
TX to LT: 2003.0917;
add/	drivers_isdn_version.patch
TX to maintainers: 2003.0917;
add/	drivers_char_version.patch
TX to LT: 2003.0917;
	From: Randy Hron <rwhron@earthlink.net>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New for -kj2:

add/	version_drivers_mtd.patch
TX to dwmw2: 2003.0917;
add/	version_oss_dmasound.patch (needs 260-test5-bk3)
add/	version_drivers_cdrom.patch
TX to maint & LT: 2003.0917;
	From: Randy Hron <rwhron@earthlink.net>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New for -kj3:

add/	arch_arm_common_taskrun.patch
add/	atm_he_taskrun.patch
add/	drivers_char_taskrun.patch
add/	fs_nfsd_taskrun.patch
add/	net_all_taskrun.patch
add/	net_wan_taskrun.patch
add/	sbus_char_taskrun.patch
add/	serial_core_taskrun.patch
add/	sound_all_taskrun.patch
add/	video_sa1100fb_taskrun.patch
	From: Alexey Dobriyan <adobriyan@mail.ru>

add/	base_bus_extra.patch
add/	fs_nfsd_register.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

add/	block_cciss_procfs.patch
add/	block_cpqarray_procfs.patch
add/	char_toshiba_procfs.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	net_natsemi_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

add/	include_includes.patch
	From: Randy Hron <rwhron@earthlink.net>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New for 2.6.0-test6-kj1:

add/	acpi_toshiba_includes.patch
	From: Randy Hron <rwhron@earthlink.net>

add/	net_wan_sbni_verify.patch
	From: Domen Puncer <domen@coderock.org>

add/	net_wireless_arlan_includes.patch
	From: Randy Hron <rwhron@earthlink.net>

add/	timer_h_noconfig.patch
	From: Matthew Wilcox <willy@debian.org>

rediff/	devfs_cdev_misc_reg.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Merged:

add/	input_init_procfs2.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
TX/M/ to LT/vojtech: 2003.0917;

add/	input_noprocfs.patch
	From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
TX/M/ to LT/vojtech: 2003.0917;

add/	net_ns83820_err_handling.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
TX/M/ to jgarzik/netdev: 2003.0917;

add/	net_rcpci_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
TX/M/ to jgarzik/netdev: 2003.0917;

/	version_sound_drivers.patch
TX/M/ to LT/maints: 2003.0917;
/	version_net.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	version_net_wanrouter.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	version_wireless.patch
TX/M/ to jgarzik/netdev/jt: 2003.0917;
/	version_sk98lin.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	version_skfp.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	drivers_net_wan.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	drivers_net_hamradio.patch
TX/M/ to jgarzik/netdev: 2003.0917;
/	drivers_net_tokenring.patch
TX/M/ to jgarzik/netdev/maint: 2003.0917;
	From: Randy Hron <rwhron@earthlink.net>
/	version_drivers_usb.patch
TX/M/ to gkh: 2003.0917;
/	version_sbus_char.patch
TX/M/ to Pete/davem: 2003.0917;
/	version_drivers_pnp_isapnp.patch
TX/M/ to LT/perex: 2003.0917;

*	rm_last_SMP.patch (by rddunlap)
TX/M/ to akpm: 2003.0918;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Merged: (new)

rediff/	scsi_sg_register.patch
	From: Daniele Bellucci <bellucda@tiscali.it>
TX/M/ to jejb/scsi: 2003.0917;

add/	char_riolinux_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to LT, Rogier Wolff <R.E.Wolff@bitwizard.nl>, Patrick van de Lageweg <patrick@bitwizard.nl>: 2003.0925;

add/	char_sx_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to LT, R.E.Wolff@BitWizard.nl: 2003.0925;

add/	coda_upcall_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to Jan Harkes <jaharkes@cs.cmu.edu>: 2003.0925;

add/	h8300_ptrace_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to Yoshinori Sato <ysato@users.sourceforge.jp>: 2003.0925;

add/	isdn_common_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to kkeil@suse.de, kai.germaschewski@gmx.de: 2003.0925;

add/	isdn_hisax_isar_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to kkeil@suse.de, kai.germaschewski@gmx.de: 2003.0925;

add/	net_bluetooth_hcicore_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to davem, maxk@qualcomm.com: 2003.0925;

add/	net_wireless_orinoco_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to jgarzik, David Gibson <hermes@gibson.dropbear.id.au>: 2003.0925;

add/	s390_net_ctctty_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap
/TX/M/ to schwidefsky@de.ibm.com: 2003.0925;

add/	sbus_jsflash_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap
/TX/M/ to zaitcev@yahoo.com: 2003.0925;

add/	serial_68328_verify.patch
	From: Domen Puncer <domen@coderock.org> and Randy Dunlap
/TX/M/ to Greg Ungerer <gerg@snapgear.com>: 2003.0925;

add/	serial_mcfserial_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to Greg Ungerer <gerg@snapgear.com>: 2003.0925;

/	serial_mcf_includes.patch
/TX/M/ to Greg Ungerer <gerg@snapgear.com>: 2003.0925;

add/	serial_tx3912_verify.patch
	From: Domen Puncer <domen@coderock.org>
/TX/M/ to LT, Steven J. Hill (sjhill@realitydiluted.com): 2003.0925;

/	version_drivers_scsi.patch
TX/M/ to jejb/scsi: 2003.0917;

/	fs_intermezzo_includes.patch
TX to m-l & LT: 2003.0917;
/TX/M/ to LT: 2003.0925;

add/	printk_newlines.patch
	From: maximilian attems <janitor@sternwelten.at>
TX to LT & ak: 2003.0917;
/TX/M/ to LT: 2003.0925;

/	version_drivers_pcmcia.patch
TX/M/ to rmk: 2003.0917;

/	version_drivers_s390.patch
TX/M/ to S390 maint: 2003.0917;
some merged

/	fs_all_includes.patch
/TX/M/ to LT: 2003.0925;

/	net_e100_includes.patch
/TX/M/ to jgarzik/scott.feldman: 2003.0925;

/	scsi_a3000_includes.patch
/TX/M/ to jejb: 2003.0925;
/	scsi_dpt_includes.patch
/TX/M/ to jejb: 2003.0925;
/	scsi_in2000_includes.patch
/TX/M/ to jejb: 2003.0925;
/	scsi_megaraid_includes.patch
/TX/M/ to jejb: 2003.0925;
/	scsi_osst_includes.patch
/TX/M/ to jejb: 2003.0925;
/	scsi_sym53c416_includes.patch
/TX/M/ to jejb: 2003.0925;

/	tc_zs_includes.patch
/TX/M/ to LT: 2003.0925;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Dropped:

drop/	net_wan_sbni_verify.patch
	From: Domen Puncer <domen@coderock.org>
patch failure; updated by Domen

drop/	pnpbios_procfs.patch (updated by rddunlap)
by request

###

--
~Randy
