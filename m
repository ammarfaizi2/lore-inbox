Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbTBDUGK>; Tue, 4 Feb 2003 15:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTBDUGK>; Tue, 4 Feb 2003 15:06:10 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:739 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267443AbTBDUGJ>; Tue, 4 Feb 2003 15:06:09 -0500
Date: Tue, 4 Feb 2003 15:14:11 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: cleanup of filesystems menu
Message-ID: <Pine.LNX.4.44.0302041512090.16603-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  randy dunlap was gracious enough to post my proposed
patch to clean up the filesystems config menu.  the patch
(80K uncompressed) is online at;

  http://www.xenotime.net/linux/kconfig/kconfig-fs-2.5.59b.patch

currently, it still has leading asterisks in front of the
config entries to support editing in emacs outline mode, 
but future patches will have these removed.

  it should patch cleanly against stock 2.5.59.

  comments?

rday

