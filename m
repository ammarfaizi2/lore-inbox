Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbSKSGRt>; Tue, 19 Nov 2002 01:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSKSGRN>; Tue, 19 Nov 2002 01:17:13 -0500
Received: from dp.samba.org ([66.70.73.150]:52149 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267114AbSKSGQS>;
	Tue, 19 Nov 2002 01:16:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: SL Baur <steve@kbuxd.necst.nec.co.jp>
Subject: [ANNOUNCE] Backwards compat modutils SRPM
Date: Tue, 19 Nov 2002 17:04:33 +1100
Message-Id: <20021119062321.AEB2A2C491@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Baur has kindly provided a source rpm which includes
module-init-tools 0.7 as well as modutils, allowing you to install it
without screwing your package manager.  I haven't tested it (Debian
here), but it looks to be the right solution.

http://www.kernel.org/pub/linux/kernel/people/rusty/modules/modutils-2.4.21-4.src.rpm

This is also the location of the module-init-tools from now on, as I
release them.

Cheers,
Rusty.
PS.  Am returning to .au today.  Once I'm back (and recovered),
     development will speed up again, I promise.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
