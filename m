Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSHBTZo>; Fri, 2 Aug 2002 15:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSHBTZo>; Fri, 2 Aug 2002 15:25:44 -0400
Received: from mnh-1-30.mv.com ([207.22.10.62]:16901 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S316792AbSHBTZn>;
	Fri, 2 Aug 2002 15:25:43 -0400
Message-Id: <200208022032.PAA03622@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: UML 2.5.30
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 15:32:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.30 and UML 2.4.18-49.  Most of the UML-specific
stuff has been in hppfs, which isn't in this patch.  The exception is
a fix for a crash caused by killing a UML xterm.

Since UML didn't make 2.5.30, I'll be sending this patch in to Linus.

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.30-1.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff

