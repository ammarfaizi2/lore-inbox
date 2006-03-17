Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWCQHWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWCQHWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbWCQHWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:22:38 -0500
Received: from mx1.suse.de ([195.135.220.2]:49800 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750851AbWCQHWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:22:37 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 18:21:21 +1100
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 000 of 6] md: Introduction - patching those patches.
Message-ID: <20060317181912.28543.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the "Andrew Morton: Awesome code reviewer" patch series, that fixes
up issues identified in my recent series of md patches.

NeilBrown


 [PATCH 001 of 6] md: INIT_LIST_HEAD to LIST_HEAD conversions.
 [PATCH 002 of 6] md: Documentation and tidy up for resize_stripes
 [PATCH 003 of 6] md: Remove an unused variable.
 [PATCH 004 of 6] md: Improve comments about locking situation in raid5 make_request
 [PATCH 005 of 6] md: Remove some stray semi-colons after functions called in macro....
 [PATCH 006 of 6] md: Make new function stripe_to_pdidx static.
