Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317032AbSFAT62>; Sat, 1 Jun 2002 15:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317031AbSFAT61>; Sat, 1 Jun 2002 15:58:27 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:9147 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317032AbSFAT6Y>; Sat, 1 Jun 2002 15:58:24 -0400
Date: Sat, 1 Jun 2002 13:57:53 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5 12/12: scsi stuff
Message-ID: <Pine.LNX.4.44.0206011356580.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - scsi stuff

This stuff has grown by running script_asm.pl. It's free for
debate whether it's useful.

You shouldn't need this patch to build with kbuild-2.5.
If you have these scsi controllers, it might be useful to have.
There seems no point in patching this into the kernel without
applying the rest of kbuild-2.5.

This patch is available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-scsi-drivers.patch>

