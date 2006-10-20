Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422798AbWJTDZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWJTDZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWJTDZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:25:31 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15766 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751648AbWJTDZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:25:30 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 20 Oct 2006 13:25:23 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@kernel.org
Subject: [PATCH 000 of 4] md: Introduction - bugfix patches for md.
Message-ID: <20061020120612.29297.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are 4 bugfix patches for md.
The first is suitable for 2.6.18.2.  All are suitable for 2.6.19.

Thanks,
NeilBrown


 [PATCH 001 of 4] md: Fix calculation of ->degraded for multipath and raid10
 [PATCH 002 of 4] md: Add another COMPAT_IOCTL for md.
 [PATCH 003 of 4] md: Endian annotation for v1 superblock access.
 [PATCH 004 of 4] md: Endian annotations for the bitmap superblock
