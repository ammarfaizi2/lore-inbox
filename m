Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268254AbTALG6T>; Sun, 12 Jan 2003 01:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268255AbTALG6T>; Sun, 12 Jan 2003 01:58:19 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:55937 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268254AbTALG6S>; Sun, 12 Jan 2003 01:58:18 -0500
Date: Sun, 12 Jan 2003 02:07:13 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: two more oddities with the fs/Kconfig file
Message-ID: <Pine.LNX.4.44.0301120139010.21998-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  there are a few options that are categorized as simply
"bool", with no following label -- examples being UMSDOS,
QUOTACTL, and a couple of others.  without a label on that
line, the option is not displayed for selection anywhere
on the menu.  is this deliberate?

  also, right near the bottom of the file, there are three
options (ZISOFS_FS, FS_MBCACHE and FS_POSIX_ACL), that are
defined after the first submenu, and they don't appear to
show up anywhere on the screen for selection either.  where
are these supposed to be displayed?

rday

