Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbSKUPeT>; Thu, 21 Nov 2002 10:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSKUPeT>; Thu, 21 Nov 2002 10:34:19 -0500
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:34025 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP
	id <S266765AbSKUPeR>; Thu, 21 Nov 2002 10:34:17 -0500
Date: Thu, 21 Nov 2002 16:41:25 +0100 (CET)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: linux-kernel@vger.kernel.org
Subject: patch 2.4.20-rc2-ac2 doesn't apply cleanly
Message-ID: <Pine.LNX.4.44.0211211634380.4670-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

patch-2.4.20-rc2-ac2.bz2 doesn't apply cleanly. Maybe it was diffed
against 2.4.20-rc1 ??? Makefile.rej contains

***************
*** 1,7 ****
  VERSION = 2
  PATCHLEVEL = 4
  SUBLEVEL = 20
- EXTRAVERSION = -rc1

  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

--- 1,7 ----
  VERSION = 2
  PATCHLEVEL = 4
  SUBLEVEL = 20
+ EXTRAVERSION = -rc2-ac2

  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)


Best Regards,

  Sandor Geller <wildy@petra.hos.u-szeged.hu>

