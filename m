Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbTBQUtr>; Mon, 17 Feb 2003 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbTBQUtr>; Mon, 17 Feb 2003 15:49:47 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:58321 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267469AbTBQUtr>; Mon, 17 Feb 2003 15:49:47 -0500
Date: Mon, 17 Feb 2003 15:56:59 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ok, one more time -- FS config file patch for cleanup
Message-ID: <Pine.LNX.4.44.0302171554140.6201-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  for anyone's who's interested, my latest submission for a
cleaner config file for filesystems is online at:

http://www.xenotime.net/linux/kconfig/fsmenu-2561.patch

  i did nothing more than move stuff around and make some
submenus -- the config entries are as they were in the
stock 2.5.61 release, but now grouped logically with 
more common stuff at the top and more obscure stuff
lower down in each menu.

  comments?  it may not be ideal, but it's a starting point,
while i move on to other parts of the menu structure.

rday

