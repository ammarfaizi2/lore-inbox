Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282687AbRLVVqb>; Sat, 22 Dec 2001 16:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282691AbRLVVqW>; Sat, 22 Dec 2001 16:46:22 -0500
Received: from Soo.com ([199.202.113.33]:46354 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id <S282687AbRLVVqF>;
	Sat, 22 Dec 2001 16:46:05 -0500
Date: Sat, 22 Dec 2001 16:46:02 -0500
From: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.2-pre1 oddness under X
Message-ID: <20011222164602.A20623@Sophia.soo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running kernel 2.5.2-pre1 compiled with gcc 3.0.3,
i get the following error irregularly when starting
X or trying to compile sawfish in an xterm:

Inconsistency detected by ld.so: dynamic-link.h: 62: elf_get_dynamic_info: Assertion `! "bad dynamic tag"' failed!

Have no idea what it means, and it doesn't happen
under any earlier 2.5.X kernels using the same
compiler.

Am also using binutils-2.11.2 and glibc-2.2.4.

b <mason_at_soo_dot_com>
