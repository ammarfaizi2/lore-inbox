Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269226AbRHLOZ7>; Sun, 12 Aug 2001 10:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269232AbRHLOZt>; Sun, 12 Aug 2001 10:25:49 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:518 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269226AbRHLOZi>;
	Sun, 12 Aug 2001 10:25:38 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: kbuild-2.5 against 2.4.8-ac1 is available
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Aug 2001 00:25:43 +1000
Message-ID: <3507.997626343@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.1, file kbuild-2.5-2.4.8-ac1.bz2.  This extends kbuild 2.5
from 2.4.8 to 2.4.8-ac1.

Apply this patch in the following order.

  Kernel 2.4.8
  patch-2.4.8-ac1
  kbuild-2.5-2.4.8-2 from http://sourceforge.net/projects/kbuild/
  This patch

  It may or may not work, if it eats your system for breakfast, fix it
  and send patches to kbuild-devel@lists.sourceforge.net.  If you want
  a patch against a more recent -ac kernel and there is not one on
  sourceforge, upgrade the Makefile.in files yourself and send your
  updates to kbuild-devel.

  This patch contains both drm and drm 4.0, as for -ac1.  Pity, I
  thought I had seen the last of the drm 4.0 Makefile abomination.

