Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSFAT5T>; Sat, 1 Jun 2002 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317032AbSFAT5S>; Sat, 1 Jun 2002 15:57:18 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:62906 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317030AbSFAT5Q>; Sat, 1 Jun 2002 15:57:16 -0400
Date: Sat, 1 Jun 2002 13:56:48 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5 7/12: miscellaneous makefiles
Message-ID: <Pine.LNX.4.44.0206011355390.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - miscellaneous makefiles

Here we have misc Makefiles patched and/or added.

You will need this patch in generic for kbuild-2.5.
You can still compile the kernel with only this patch applied, but then
you could even leave it. You'd better pull the rest of kbuild-2.5, too.

This patch is available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-makefile-others.patch>

