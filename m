Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWCTEiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWCTEiU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWCTEiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:38:20 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:44047 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751359AbWCTEiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:38:19 -0500
Date: Mon, 20 Mar 2006 04:38:03 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Bring mainline in sync with the linux-mips tree
Message-ID: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a series of twelve patches to bring mainline in
sync with the linux-mips tree.  These are changes that have to be
made in mainline.  Another series has already been posted to
the linux-mips list to bring linux-mips in sync with Linus' tree
where necessary.

[PATCH 1/12] [MIPS] Improve description of VR41xx based machines
[PATCH 2/12] [MIPS] Cosmetic updates to sync with linux-mips
[PATCH 3/12] [MIPS] Remove tb0287_defconfig
[PATCH 4/12] [NET] Improve description of MV643XX_ETH
[PATCH 5/12] [NET] Bring declance.c in sync with linux-mips tree
[PATCH 6/12] [NET] Support the BCM1x55 and BCM1x80 chips
[PATCH 7/12] [IDE] Set CFLAGS only for au1xxx-ide
[PATCH 8/12] [MTD] Re-add module description for ms02-nv to Kconfig
[PATCH 9/12] [MTD] Fix #else directive in the docprobe driver
[PATCH 10/12] [MTD] LASAT depends on MTD_CFI
[PATCH 11/12] [USB] Cosmetic changes to bring ohci-au1xxx.c in sync with linux-mips
[PATCH 12/12] [SCSI] mem_start is a physical address already

-- 
Martin Michlmayr
http://www.cyrius.com/
