Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUEVOkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUEVOkG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUEVOkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:40:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:18571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261416AbUEVOkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:40:03 -0400
Date: Sat, 22 May 2004 07:40:02 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200405221440.i4MEe2Yd008340@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.6 - 2004-05-21.22.30) - 6 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: "jffs2_add_physical_node_ref" [fs/jffs2/jffs2.ko] undefined!
*** Warning: "jffs2_alloc_raw_node_ref" [fs/jffs2/jffs2.ko] undefined!
*** Warning: "jffs2_erase_pending_trigger" [fs/jffs2/jffs2.ko] undefined!
*** Warning: "jffs2_flash_direct_writev" [fs/jffs2/jffs2.ko] undefined!
*** Warning: "jffs2_garbage_collect_pass" [fs/jffs2/jffs2.ko] undefined!
*** Warning: "jffs2_reserve_space_gc" [fs/jffs2/jffs2.ko] undefined!
