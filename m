Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVHHWaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVHHWaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVHHWaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:30:11 -0400
Received: from coderock.org ([193.77.147.115]:21891 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932298AbVHHWaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:30:09 -0400
Message-Id: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:36 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 00/16] old kernel janitor patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, folks.

Here are patches I'm sending for inclusion in -mm tree.
Patches were in -kj tree for more than five months, and as far
as I can tell, they received no negative feedback.


List of them, which is a bit descriptive:

min-max-ide_ide-timing.h.patch
list-for-each-entry-drivers_net_ppp_generic.patch
list-for-each-entry-fs_jffs_intrep.patch
list-for-each-entry-fs_namespace.patch
list-for-each-fs_dcache.patch
msleep-drivers_ide_ide-tape.patch
pr_debug-drivers_block_umem.patch
list-for-each-drivers_net_tulip_de4x5.patch
min-max-arch_sh_boards_bigsur_io.patch
min-max-arch_sh_cchips_hd6446x_hd64465_io.patch
msleep-drivers_block_xd.patch
msleep-drivers_ide_ide-cs.patch
set_current_state-drivers_net_irda_stir4200.patch
set_current_state-drivers_net_tokenring_tms380tr.patch
vfree-fs_reiserfs_super.patch
wait_event-drivers_block_ps2esdi.patch
