Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRAIWtO>; Tue, 9 Jan 2001 17:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132282AbRAIWs4>; Tue, 9 Jan 2001 17:48:56 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:41618 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S132271AbRAIWsg>; Tue, 9 Jan 2001 17:48:36 -0500
Message-ID: <3A5B961B.857B8802@paulbristow.net>
Date: Tue, 09 Jan 2001 23:52:11 +0100
From: Paul Bristow <paul@paulbristow.net>
Organization: http://paulbristow.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.0 MAINTAINERS for ide-floppy updates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,

Could you please apply this patch to the MAINTAINERS file so that the
2.4.x
IDE-FLOPPY maintainer is correctly identified as me and not Gadi any
more.
This change happened at 2.2.18 for the 2.2.x tree.

I am discussing with Sam the previous patch that Alan applied in
2.4.0-ac4 for 1.44M floppy formatting in LS-120 drives.

Regards,

-- 

Paul

Email:	paul@paulbristow.net
Web:	http://paulbristow.net
ICQ:	11965223


Patch follows

diff -ur linux-2.4.0/MAINTAINERS linux/MAINTAINERS
--- linux-2.4.0/MAINTAINERS     Sun Dec 31 18:31:15 2000
+++ linux/MAINTAINERS   Tue Jan  9 23:20:48 2001
@@ -594,9 +594,16 @@
 W:     http://www.kernel.dk
 S:     Maintained
 
-IDE/ATAPI TAPE/FLOPPY DRIVERS
+IDE/ATAPI TAPE DRIVERS
 P:     Gadi Oxman
 M:     Gadi Oxman <gadio@netvision.net.il>
+L:     linux-kernel@vger.kernel.org
+S:     Maintained
+
+IDE/ATAPI FLOPPY DRIVERS
+P:     Paul Bristow
+M:     Paul Bristow <paul@paulbristow.net>
+W:     http://paulbristow.net/linux/idefloppy.html
 L:     linux-kernel@vger.kernel.org
 S:     Maintained
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
