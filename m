Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUL2Unc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUL2Unc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 15:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUL2Unc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 15:43:32 -0500
Received: from terminus.zytor.com ([209.128.68.124]:4301 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261416AbUL2Un3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 15:43:29 -0500
Message-ID: <41D31696.8050701@zytor.com>
Date: Wed, 29 Dec 2004 12:41:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] i386 boot loader IDs
Content-Type: multipart/mixed;
 boundary="------------020207070708000204090605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020207070708000204090605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds some i386 boot loader IDs that were used but never 
officially recorded as assigned.  This makes them nice and official.

	-hpa

Signed-Off-By: H. Peter Anvin <hpa@zytor.com>

--------------020207070708000204090605
Content-Type: text/x-patch;
 name="bootid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootid.patch"

Index: linux-2.5/Documentation/i386/boot.txt
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/Documentation/i386/boot.txt,v
retrieving revision 1.6
diff -u -r1.6 boot.txt
--- linux-2.5/Documentation/i386/boot.txt	2 Aug 2004 17:14:55 -0000	1.6
+++ linux-2.5/Documentation/i386/boot.txt	29 Dec 2004 20:31:14 -0000
@@ -173,6 +173,9 @@
 	2  bootsect-loader
 	3  SYSLINUX
 	4  EtherBoot
+	5  ELILO
+	7  GRuB
+	8  U-BOOT
 
 	Please contact <hpa@zytor.com> if you need a bootloader ID
 	value assigned.

--------------020207070708000204090605--
