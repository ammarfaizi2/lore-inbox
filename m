Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266723AbSKEA6C>; Mon, 4 Nov 2002 19:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSKEA6B>; Mon, 4 Nov 2002 19:58:01 -0500
Received: from dp.samba.org ([66.70.73.150]:53954 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266723AbSKEA5y>;
	Mon, 4 Nov 2002 19:57:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Module loader against 2.5.46: Summary
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-reply-to: Your message of "Tue, 05 Nov 2002 11:47:27 +1100."
Date: Tue, 05 Nov 2002 12:04:00 +1100
Message-Id: <20021105010428.BA0932C0AB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of module patches
=========================

Still pending in my patchqueue (I didn't want to swamp Linus).
      Other architectures (ppc, ppc64, sparc, sparc64, ia64)
      Module license support
      Exception table walk cleanup
      Documentation on writing module-compatible interfaces
      Modversions reimplementations (under discussion with Kai)
	- Requires a second pass, but allows mixing of versioned &
	  non-versioned kernels and modules.

Not done yet:
      DEVICE_TABLE support
	- Discussions with gregkh on not exporting the in-kernel
	  datastructure and using module aliases.
      Other archs (alpha, arm, cris, m68k, mips, mips64, parisc, s390,
	    s390x, sh, v850, x86_64)
Q
uestions welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
