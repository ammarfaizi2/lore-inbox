Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282069AbRKVIQk>; Thu, 22 Nov 2001 03:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282071AbRKVIQa>; Thu, 22 Nov 2001 03:16:30 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:19986 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S282069AbRKVIQO>; Thu, 22 Nov 2001 03:16:14 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Updated parameter and modules rewrite (2.4.14)
Date: Thu, 22 Nov 2001 19:15:49 +1100
Message-Id: <E166p1R-0004ll-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   http://ftp.kernel.org/pub/linux/kernel/people/rusty

	Unified boot/module parameter and module loader rewrite
updated to 2.4.14.  I'm off to Linux Kongress, so I'll be difficult to
contact for 10 days or so.

Main TODOS:
	1) Should the PARAM() macros also declare the variables?
		Lots of people seem to like writing INT_MODULE_PARM macros...

	2) Need a less-sucky /proc|/proc/sys patch, to add access to
	   parameters through that.

Cheers!
Rusty.
--
Premature optmztion is rt of all evl. --DK
