Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSIWT1u>; Mon, 23 Sep 2002 15:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSIWT05>; Mon, 23 Sep 2002 15:26:57 -0400
Received: from mnh-1-28.mv.com ([207.22.10.60]:35589 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261347AbSIWTZP>;
	Mon, 23 Sep 2002 15:25:15 -0400
Message-Id: <200209232034.PAA03655@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.5.38-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Sep 2002 15:34:57 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.38.

Thanks to comments from Al Viro and fixes from James McMechan, the block
driver is up to date with the block layer changes.

There were some fixes to keep up with the latest kbuild, including some
changes in the top-level Makefile, which I'll be feeding to Kai.

There were also a number of smaller fixes to update to 2.5.38, a number
of which came from Nikita Danilov.

I'll be feeding these changes to Linus.

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.38-1.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff

