Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbUARDIa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 22:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUARDI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 22:08:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:55517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265553AbUARDH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 22:07:59 -0500
Date: Sat, 17 Jan 2004 19:04:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.1-bk4-kj1 patchset
Message-Id: <20040117190410.218ebcd3.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.1-bk4/2.6.1-bk4-kj1.patch.bz2  [2004-01-16]

This patch applies to linux-2.6.1-bk4.

new (for 2.6.1-bk4):  [2004-01-16]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add	config_ledman_rm.patch
	From: Domen Puncer <domen@coderock.org>

add	ipt_register_target_retval.patch
	From: Daniele Bellucci <bellucda@tiscali.it>

add	kconfig_cleanups_v1.patch
	From: Matthew Wilcox <willy@debian.org>

add	kswapd_init_fail.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>

add	lmc_proto_raw_h_rm.patch
	From: Domen Puncer <domen@coderock.org>

add	netdev_rm_casts.patch
	From: Carlo Perassi <carlo@linux.it>

add	s390_net_ctctty_putuser.patch
	From: Domen Puncer <domen@coderock.org>

add	setup_bootmem_fail.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>

add	skfddi_regions_pciupdate.patch
	From: Matthew Wilcox <willy@debian.org>

add	acpi_boot_message_typo.patch
	From: Simon Richard Grint <rgrint@mrtall.compsoc.man.ac.uk>

add	cpcihp_zt5550_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

add	mfcserial_vrfyarea.patch
	From: Domen Puncer <domen@coderock.org>

add	vga16fb.c_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

add	vgastate.c_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

add	tc35815.c_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

add	depca_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

add	dgrs_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>

previous (for 2.6.1):  [2004-01-13]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add	fdport.patch: reorder outb() macro names to reflect reality;
	From: Randy Dunlap <rddunlap@osdl.org>

add	vmdocs.patch
	From: Patrick McLean <pmclean@linuxfreak.ca>

add	2.6_spelling_Unix98.diff.patch
	From: Andreas Beckmann <sparclinux@abeckmann.de>

add	md_notifdef.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add	fsstat64.patch
	From: Michael Still <mikal@stillhq.com>

previous (for 2.6.1-rc3):  [2004-01-08]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add	update EXTRAVERSION: add -kj1

add	amd74_noprocfs.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add	apm_thread_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	cifs_dalloc_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	init_thread_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	ipv4_ipmr_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	mca_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	md_noprocfs.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add	mminit_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	pdflush_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	setfpxregs_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	siimage_noprocfs2.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add	sunrpc_retval.patch
	From: Eugene TEO <eugeneteo@eugeneteo.net>

add	tr3c_kmalloc.patch
	From: Pablo Menichini <pablo@menichini.com.ar>
	and maximilian attems <janitor@sternwelten.at>

###
--
~Randy
Everything is relative.
