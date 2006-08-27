Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWH0XtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWH0XtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWH0XtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:49:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:1664 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750980AbWH0XtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:49:14 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 28 Aug 2006 09:49:12 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 4] md: Introduction - some revised/reordered patches.
Message-ID: <20060828092849.21292.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are revisions of 4 patches currently in -rc4-mm3
which reorder the last to be the first, as that first should
go to 2.6.18, but the others don't need to.

The patches are:

md-fix-issues-with-referencing-rdev-in-md-raid1.patch
md-factor-out-part-of-raid1d-into-a-separate-function.patch
md-remove-working_disks-from-raid1-state-data.patch
md-improve-locking-around-error-handling.patch

The first one listed above was at the end of the list, and should
go into 2.6.18.

Thanks,
NeilBrown
