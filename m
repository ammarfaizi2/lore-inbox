Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUBGAef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUBGAee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:34:34 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:35855 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265596AbUBGAed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:34:33 -0500
Date: Sat, 7 Feb 2004 00:34:29 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fbdev sysfs support.
Message-ID: <Pine.LNX.4.44.0402070032030.19559-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull http://fbdev.bkbits.net/fbdev-2.6

This will update the following files:

 drivers/video/Makefile  |    2 
 drivers/video/fbmem.c   |    6 ++
 drivers/video/fbsysfs.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h      |   40 ++++++++++-------
 4 files changed, 141 insertions(+), 17 deletions(-)

through these ChangeSets:

<jsimmons@infradead.org> (04/02/06 1.1549)
   [FBDEV] Add syfs support.


