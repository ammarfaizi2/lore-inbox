Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUANA3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266280AbUANA2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:28:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:14003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266271AbUANA2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:28:10 -0500
Date: Tue, 13 Jan 2004 16:24:55 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.1-kj1 patchset
Message-Id: <20040113162455.2f086d72.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.1/2.6.1-kj1.patch.bz2  [2004-01-13]

This patch applies to linux-2.6.1.

new (for 2.6.1):  [2004-01-13]
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
MOTD:  Always include version info.
