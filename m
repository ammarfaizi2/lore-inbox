Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316849AbSFATzy>; Sat, 1 Jun 2002 15:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317028AbSFATzx>; Sat, 1 Jun 2002 15:55:53 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:47546 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316849AbSFATzs>; Sat, 1 Jun 2002 15:55:48 -0400
Date: Sat, 1 Jun 2002 13:55:24 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5 6/12: Makefile.in's
Message-ID: <Pine.LNX.4.44.0206011354030.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - Makefile.in's

Here we have the Makefile.in's for kbuild-2.5.
They're painstakingly easy to edit...

You will definitely need this patch for kbuild-2.5.
You can compile the kernel with only this patch enabled, but it won't
make too much sense. You should consider gathering all kbuild-2.5 patches.

This patch is available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-makefile-ins.patch>


