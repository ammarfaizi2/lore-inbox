Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130190AbRAUQH0>; Sun, 21 Jan 2001 11:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRAUQHQ>; Sun, 21 Jan 2001 11:07:16 -0500
Received: from m263-mp1-cvx1c.col.ntl.com ([213.104.77.7]:16900 "EHLO
	[213.104.77.7]") by vger.kernel.org with ESMTP id <S129652AbRAUQHB>;
	Sun, 21 Jan 2001 11:07:01 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>
Subject: [PATCH] include/linux/rtc.h tiny typo
From: "John Fremlin" <vii@altern.org>
Date: 21 Jan 2001 16:10:05 +0000
Message-ID: <m2itn8rin6.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Against 2.4.0.

--- linux/include/linux/rtc.h~	Tue Jul 11 19:18:53 2000
+++ linux/include/linux/rtc.h	Sun Jan 21 16:06:53 2001
@@ -6,7 +6,7 @@
  * Copyright (C) 1999 Hewlett-Packard Co.
  * Copyright (C) 1999 Stephane Eranian <eranian@hpl.hp.com>
  */
-#ifndef _LINUX_RTC_H
+#ifndef _LINUX_RTC_H_
 #define _LINUX_RTC_H_
 
 /*
-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
