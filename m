Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbVJ1Sai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbVJ1Sai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbVJ1Sai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:30:38 -0400
Received: from waste.org ([216.27.176.166]:14727 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030538AbVJ1Sah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:30:37 -0400
Date: Fri, 28 Oct 2005 11:25:41 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-tiny@selenic.com, celinux-dev@waste.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14-tiny1 for small systems
Message-ID: <20051028182541.GF4367@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resync of the -tiny tree against 2.6.14. The latest patch
can be found at:

 http://selenic.com/tiny/2.6.14-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.14-tiny1-broken-out.tar.bz2

A Mercurial repository containing the latest broken out patches can be
found at:

 http://selenic.com/repo/tiny

There's a mailing list for linux-tiny development at:
 
 linux-tiny at selenic.com
 http://selenic.com/mailman/listinfo/linux-tiny

Webpage for your bookmarking pleasure:

 http://selenic.com/linux-tiny

Changes since 2.6.13.3-tiny1:

-kbuild-fix-make-clean-damaging-hg-repos.patch

Merged upstream

-kill-kmem_cache_name.patch

Implemented in SLOB allocator

-ptrace.patch
-direct-io-core.patch

Need reworking from scratch due to upstream changes

-- 
Mathematics is the supreme nostalgia of our time.
