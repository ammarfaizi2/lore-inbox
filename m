Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316801AbSFATyM>; Sat, 1 Jun 2002 15:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSFATyL>; Sat, 1 Jun 2002 15:54:11 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:38586 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316801AbSFATyK>; Sat, 1 Jun 2002 15:54:10 -0400
Date: Sat, 1 Jun 2002 13:53:56 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5 5/12: mdbm
Message-ID: <Pine.LNX.4.44.0206011352110.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - mdbm database files/programs

Here we have the very heart of kbuild-2.5: memory database, as used in
BitKeeper and others.

You will need this patch in generic for kbuild-2.5.
Your kernel will compile with only this patch enabled, but there's
no point in doing so. You should get the other kbuild-2.5 patches, too.

This patch is available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-mdbm.patch>


