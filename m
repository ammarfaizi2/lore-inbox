Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbTIKLay (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTIKLay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:30:54 -0400
Received: from boss.staszic.waw.pl ([195.205.163.66]:17844 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP id S261229AbTIKLar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:30:47 -0400
From: Marek Szyprowski <march@staszic.waw.pl>
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Sep 2003 13:26:43 +0100
Message-ID: <yam9384.2177.1200381112@boss.staszic.waw.pl>
X-Mailer: YAM 2.4p1 [040] AmigaOS E-mail Client (c) 2000-2003 by YAM Open Source Team - http://www.yam.ch/
Subject: [PATCH] ASFS filesystem patch, kernel 2.4.21
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds read-only support for Amiga SmartFileSystem. This filesystem
is being used very commonly on AmigaOS and MorphOS systems. This patch has
been tested on Linux/PPC, Linux/m68k and Linux/x86 machines. This patch is
prepared for kernel 2.4.21.

The patch is available on
http://www.staszic.waw.pl/~march/asfs/asfs-0.6_patch_2.4.21.diff
(because of the size, it has over 1000 lines).

Regards
-- 
Marek Szyprowski .. GG:2309080 .. mailto:marek@amiga.pl ..
...... happy AmigaOS, MacOS and Debian/Linux user ........
........... http://march.home.staszic.waw.pl/ ............

