Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268241AbTALFvq>; Sun, 12 Jan 2003 00:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268242AbTALFvq>; Sun, 12 Jan 2003 00:51:46 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:936 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268241AbTALFvp>; Sun, 12 Jan 2003 00:51:45 -0500
Date: Sun, 12 Jan 2003 01:00:40 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: some curiosities on the filesystems layout in kernel config
Message-ID: <Pine.LNX.4.44.0301120053420.21687-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  hoping i don't embarrass myself again ...

1) where is the USMDOS selection that's listed in the Kconfig file?
   it doesn't appear in the menu

2) shouldn't ext3 depend on ext2?

3) currently, since quotas are only supported for ext2, ext3 and
   reiserfs, shouldn't quotas depend on at least one of those
   being selected?

rday

