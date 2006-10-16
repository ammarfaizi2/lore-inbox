Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422927AbWJPXaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbWJPXaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422928AbWJPXaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:30:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:43409 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422927AbWJPXaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:30:10 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Oct 2006 09:30:04 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 5] knfsd: Introduction - bugfixes for 2.6.19
Message-ID: <20061017092702.11224.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following 5 patches for nfsd/lockd are bug fixes that are appropriate for 
2.6.19 (matches made against 2.6.18-rc1-mm1).

Thanks,
NeilBrown


 [PATCH 001 of 5] knfsd: nfsd4: fix owner-override on open
 [PATCH 002 of 5] knfsd: nfsd4: fix open permission checking
 [PATCH 003 of 5] knfsd: nfsd4: Fix error handling in nfsd's callback client
 [PATCH 004 of 5] knfsd: Fix bug in recent lockd patches that can cause reclaim to fail.
 [PATCH 005 of 5] knfsd: Allow lockd to drop replys as appropriate.
