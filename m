Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWBHHKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWBHHKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWBHHKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:10:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:19159 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161040AbWBHHKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:01 -0500
To: torvalds@osdl.org
Subject: [PATCHSET] more assorted trivial annotations and fixes
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6jSi-0002Qt-UA@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Please, pull from git.kernel.org/pub/scm/linux/kernel/git/viro/bird.git/
for-linus2.  Patches sent to l-k and Cc'd, but Linus excluded from Cc as asked.
	Shortlog:
Al Viro:
      arm: fix dependencies for MTD_XIP
      mips: namespace pollution - mem_... -> __mem_... in io.h
      s390x compat __user annotations
      powermac pci iomem annotations
      drivers/media/video __user annotations and fixes
      powerpc signal __user annotations
      sn3 iomem annotations and fixes
      compat_ioctl __user annotations
      s390 misc __user annotations
      fix iomem annotations in dart_iommu
      __user annotations in powerpc thread_info
      synclink_gt is PCI-only
      s390 __get_user() bogus warnings removal
      type-safe min() in prism54
      mark HISAX_AMD7930 as broken
      m32r_sio iomem annotations
      sh: lvalues abuse in arch/sh/boards/renesas/rts7751r2d/io.c
