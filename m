Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUAIExu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 23:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266232AbUAIExt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 23:53:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:17049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265619AbUAIEwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 23:52:45 -0500
Date: Thu, 8 Jan 2004 20:46:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.1-rc3-kj1 patchset
Message-Id: <20040108204606.5d286e22.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.1-rc3/2.6.1-rc3-kj1.patch.bz2  [2004-01-08]

This patch applies to linux-2.6.1-rc3.

new:  [2004-01-08]
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
