Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSG1P3R>; Sun, 28 Jul 2002 11:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSG1P2g>; Sun, 28 Jul 2002 11:28:36 -0400
Received: from mnh-1-03.mv.com ([207.22.10.35]:30724 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317025AbSG1P0k>;
	Sun, 28 Jul 2002 11:26:40 -0400
Message-Id: <200207281633.LAA06288@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: UML 2.5.29
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Jul 2002 11:33:40 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.29 and UML 2.4.18-46.  The changes since 2.5.28
are mostly cleanups.  The one major change, the Honeypot procfs, is not
present in this patch because I haven't yet figured out how to port filesystems
from 2.4.

Since UML didn't make 2.5.28, I'll be sending this patch in to Linus.

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.29-1.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff

