Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbUDEWId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUDEWGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:06:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:24298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263480AbUDEWDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:03:49 -0400
Date: Mon, 5 Apr 2004 15:00:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjo <kernel-janitors@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.5-kj1 patchset
Message-Id: <20040405150001.45f7671a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I'll be pushing patches to maintainers this week.)


patch is at:
http://developer.osdl.org/rddunlap/kj-patches/2.6.5/2.6.5-kj1.patch.bz2  [2004-04-05]

M: merged at kernel.org;   mm: in -mm;   tx: sent;   mntr: maintainer merged;

This patch applies to linux-2.6.5.
new (for 2.6.5-rc3):  [2004-04-05]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/	extraver.patch
	rddunlap%osdl!org

add/	remove_concat_FUNCTION_arch.patch
	remove_concat_FUNCTION_drivers.patch
	remove_concat_FUNCTION_include.patch
	remove_concat_FUNCTION_net.patch
	remove_concat_FUNCTION_sound.patch
	From: Tony Breeds <tony@bakeyournoodle.com>

This patch applies to linux-2.6.5-rc3.
new (for 2.6.5-rc3):  [2004-04-01]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/	floppy_audit_v2.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	eth1394_kmemcc.patch
	From: <WHarms@bfs.de>(Walter Harms)

add/	pcmcia_cs_class_reg.patch
	From: <WHarms@bfs.de>(Walter Harms)

add/	jfs_metapage_kmemcc.patch
	From: <WHarms@bfs.de>(Walter Harms)

add/	mandocs_params-001.patch
	mandocs_params-002.patch
	mandocs_params-003.patch
	mandocs_params-004.patch
	mandocs_params-005.patch
	mandocs_params-006.patch
	1-6 sent to mntr: 2004.0405;
	mandocs_params-007.patch
	From: mikal@stillhq.com

This patch applies to linux-2.6.5-rc1.
previous (for 2.6.5-rc1):  [2004-03-16]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/	floppy_deugli_00.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	floppy_deugli_01.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	floppy_deugli_02.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	floppy_deugli_03.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

This patch applies to linux-2.6.4-rc2.
previous (for 2.6.4-rc2):  [2004-03-09]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
add/	kswapd_init_fail.patch
	From: Eugene Teo <eugene.teo@eugeneteo.net>

tx/	lmc_proto_raw_h_rm.patch
	From: Domen Puncer <domen@coderock.org>
	sent to netdev/jgarzik: 2004.0229;

add/	ipv4_fib_hash_check.patch
	From: Francois Romieu <romieu@fr.zoreil.com>
	original From: <WHarms@bfs.de>(Walter Harms)

tx/	file2alias_signcomp.patch
fxd	From: Ron Gage <ron@rongage.org>
	sent to mntrs: 2004.0316;

tx/	fixdep_signcomp.patch
fxd	From: Ron Gage <ron@rongage.org>
	sent to mntrs: 2004.0316;

tx/	modpost_signcomp.patch
	From: Ron Gage <ron@rongage.org>
	sent to mntrs: 2004.0316;

tx/	errno_numbers_assembly.patch
	From: Danilo Piazzalunga <danilopiazza@libero.it>
	to akpm: 2004.0126;
	to akpm: 2004.0316;
	must go thru arch maintainers;

tx/	dgrs_iounmap.patch
	From: Leann Ogasawara <ogasawara@osdl.org>
	sent to jgarzik/netdev: 2004.0124;

tx/	drivers_ide_minmax.patch
	From: Michael Veeck <michael.veeck@gmx.net>
	sent to mntr/linux-ide: 2004.0316;

tx/	drivers_ide_minmax2.patch
	From: Michael Veeck <michael.veeck@gmx.net>
	sent to mntr/linux-ide: 2004.0316;

add/	keyboard_ptr_to_string.patch
	From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>

add/	string_form_drivers.patch
	From: maximilian attems <janitor@sternwelten.at>

Merged (hence dropped from here):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mntr/	nfs_parse.patch
	From: Fabian_LoneStar_Frederick <fabian.frederick@gmx.fr>
	sent to mntr: 2004.0319; he acked it & will merge it;

backlog:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- check kernel_thread() results (Walter);
- list_for_each() usage (max attems);

Dropped:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- remove sleep_on() in drivers/usb/ (Domen): needs USB feedback;

###

--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
