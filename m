Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132186AbRCVVXJ>; Thu, 22 Mar 2001 16:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132202AbRCVVW7>; Thu, 22 Mar 2001 16:22:59 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:23547 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S132186AbRCVVWv>; Thu, 22 Mar 2001 16:22:51 -0500
Message-ID: <3ABA6C8E.24825AAD@austin.ibm.com>
Date: Thu, 22 Mar 2001 15:20:14 -0600
From: Dave Kleikamp <shaggy@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/ioctl-number.txt
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
I would like to reserve a block of 32 ioctl's for the JFS filesystem.

Thank you.
Dave Kleikamp

--- linux/Documentation/ioctl-number.txt-orig	Tue Feb 13 16:13:42 2001
+++ linux/Documentation/ioctl-number.txt	Thu Mar 22 14:53:40 2001
@@ -86,6 +86,7 @@
 'F'	all	linux/fb.h
 'I'	all	linux/isdn.h
 'J'	00-1F	drivers/scsi/gdth_ioctl.h
+'J'	20-3F	linux/jfs_fs.h
 'K'	all	linux/kd.h
 'L'	00-1F	linux/loop.h
 'L'	E0-FF	linux/ppdd.h		encrypted disk device driver
