Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbTI1QP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbTI1QP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:15:56 -0400
Received: from boss.staszic.waw.pl ([195.205.163.66]:12491 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP id S262597AbTI1QPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:15:55 -0400
From: Marek Szyprowski <march@staszic.waw.pl>
To: linux-kernel@vger.kernel.org
Date: Sun, 28 Sep 2003 18:09:39 +0100
Message-ID: <yam9401.1994.1201663704@boss.staszic.waw.pl>
X-Mailer: YAM 2.4p1 [040] AmigaOS E-mail Client (c) 2000-2003 by YAM Open Source Team - http://www.yam.ch/
Subject: [PATCH] ASFS filesystem patch, kernel 2.6.0test5
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch is a quick port of my 2.4.x ASFS driver. It adds read-only
support for Amiga SmartFileSystem. This filesystem is being used very
commonly on AmigaOS and MorphOS systems. This patch has been tested on
Linux/x86 machine. This patch is prepared for kernel 2.6.0test5.

The patch is available on
http://www.staszic.waw.pl/~march/asfs/asfs-0.6_patch_2.6.0t5.diff
(because of the size, it has over 1000 lines).

Regards
-- 
Marek Szyprowski .. GG:2309080 .. mailto:marek@amiga.pl ..
...... happy AmigaOS, MacOS and Debian/Linux user ........
........... http://march.home.staszic.waw.pl/ ............

