Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319380AbSIFUkO>; Fri, 6 Sep 2002 16:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319381AbSIFUkO>; Fri, 6 Sep 2002 16:40:14 -0400
Received: from mnh-1-22.mv.com ([207.22.10.54]:30213 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S319380AbSIFUkN>;
	Fri, 6 Sep 2002 16:40:13 -0400
Message-Id: <200209062148.QAA03922@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: UML 2.5.33
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Sep 2002 16:48:48 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.33 and UML 2.4.19-2.

Other changes include
	Fixed a couple of jail mode crashes
	Fixed a crash caused by not properly copying the fpstate pointer
during a signal delivery
	Fixed a stupid typo in uaccess.h.
	Ethernet devices now are guaranteed to end up with the same names
that were specified on the command line

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.33-1.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff

