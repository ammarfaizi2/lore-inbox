Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbRDJXfj>; Tue, 10 Apr 2001 19:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDJXf3>; Tue, 10 Apr 2001 19:35:29 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:36346 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132478AbRDJXfS>; Tue, 10 Apr 2001 19:35:18 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104102335.f3ANZBkR000510@webber.adilger.int>
Subject: [PATCH] register ioctl number of LVM
To: Linux kernel development list <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2001 17:35:11 -0600 (MDT)
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds the LVM ioctl number to Documentation/ioctl-numer.txt.
I had previously sent this directly to MEC as well.

Cheers, Andreas
==============================================================================
--- linux.orig/Documentation/ioctl-number.txt	Tue Apr 10 17:13:00 2001
+++ linux/Documentation/ioctl-number.txt	Tue Apr 10 17:10:40 2001
@@ -186,3 +186,5 @@
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
 0xCB	00-1F	CBM serial IEC bus      in development:
 					<mailto:michael.klein@puffin.lb.shuttle.de>
+
+0xFE	00-9F	Logical Volume Manager	<mailto:linux-lvm@sistina.com>

-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
