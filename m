Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSGVEuS>; Mon, 22 Jul 2002 00:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSGVEuS>; Mon, 22 Jul 2002 00:50:18 -0400
Received: from mnh-1-27.mv.com ([207.22.10.59]:61446 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S316187AbSGVEuR>;
	Mon, 22 Jul 2002 00:50:17 -0400
Message-Id: <200207220556.AAA04324@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
Subject: UML 2.5.27
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Jul 2002 00:56:20 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.27 and UML 2.4.18-42.  The changes since 
2.4.18-40 include:

	the terminal emulator that UML uses is now configurable
	fixed a race in 'jail' mode with threaded processes segfaulting
	various build fixes and code cleanups

Since UML didn't make 2.5.27, I'll be sending this patch in to Linus.

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.27-1.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff


