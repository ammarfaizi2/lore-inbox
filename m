Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSENIsl>; Tue, 14 May 2002 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315514AbSENIsk>; Tue, 14 May 2002 04:48:40 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:57225 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315487AbSENIsj> convert rfc822-to-8bit; Tue, 14 May 2002 04:48:39 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: Denis Oliver Kropp <dok@directfb.org>
Subject: Re: [PATCH] vmwarefb 0.5.0
Date: Tue, 14 May 2002 10:48:12 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205141048.12576.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,


diff -uraN linux-2.4.19-pre8/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.4.19-pre8/include/linux/fb.h	Tue May 14 05:11:14 2002
+++ linux/include/linux/fb.h	Tue May 14 01:24:06 2002
@@ -96,6 +96,8 @@
 #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
 #define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon family		*/
 
+#define FB_ACCEL_VMWARE_SVGA	50	/* VMware Virtual SVGA Graphics */
+#define FB_ACCE
^ ^ ^ Where is the rest? :) Looks like incomplete. Or is it only one add?

I want to test it.


-- 
Kind regards
        Marc-Christian Petersen

