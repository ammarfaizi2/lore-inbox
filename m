Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSGYUYq>; Thu, 25 Jul 2002 16:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSGYUYq>; Thu, 25 Jul 2002 16:24:46 -0400
Received: from jdike.solana.com ([198.99.130.100]:50304 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S315483AbSGYUYo>;
	Thu, 25 Jul 2002 16:24:44 -0400
Message-Id: <200207252030.g6PKUJY08599@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: UML 2.5.28
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Jul 2002 16:30:19 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.28 and UML 2.4.18-44.  The changes since 
2.5.27 include:

	A config reorganization and Makefile cleanups
	UML processes can pass notifications to mconsole clients via
/proc/mconsole
	SCSI now works.  The only low-level drivers available right
now is the in-memory scsi_debug driver.
	A batch of honeypot bugs were fixed

	I fixed some problems with hostfs, but it still doesn't work.

Since UML didn't make 2.5.27, I'll be sending this patch in to Linus.

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.28-1.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff



