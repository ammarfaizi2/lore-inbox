Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132647AbQKWHdt>; Thu, 23 Nov 2000 02:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132649AbQKWHdi>; Thu, 23 Nov 2000 02:33:38 -0500
Received: from argo.anu.edu.au ([150.203.5.57]:11648 "EHLO argo.anu.edu.au")
        by vger.kernel.org with ESMTP id <S132647AbQKWHd0>;
        Thu, 23 Nov 2000 02:33:26 -0500
Message-Id: <200011230703.eAN73J300192@argo.anu.edu.au>
Date: Thu, 23 Nov 2000 18:03:19 +1100 (EST)
To: linux-kernel@vger.kernel.org
From: bregor@anusf.anu.edu.au
Subject: boot failure since 2.4.0-test10
X-Mailer: Ishmail 1.9.12-20000718-i686-Bregor-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Others have reported similar problems, i.e.
  NOTHING after the "booting kernel message".

  My case is:
  Dual P-II Xeons, Intel 440GX chipset.
  Booting with loadlin or syslinux-1.50
  root-partition: /dev/hdc3
  Kernel freatures:  
    CPU set to Pentium-II
    No module support
    No plug "n" play
    Nothing unusual at all.  (I've tried many variations)

  I've built many kernels in the past and can still boot
  linux-2.4.0-test10.pre??? versions.

  Any advice would be most welcome.

  Roger Brown      bregor at anusf dot anu dot edu dot au

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
