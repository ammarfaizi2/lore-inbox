Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbTBESMf>; Wed, 5 Feb 2003 13:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTBESMf>; Wed, 5 Feb 2003 13:12:35 -0500
Received: from zok.sgi.com ([204.94.215.101]:32960 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261742AbTBESMd>;
	Wed, 5 Feb 2003 13:12:33 -0500
Date: Wed, 5 Feb 2003 10:22:07 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: marcelo@hera.kernel.org
Cc: jh@sgi.com, linux-kernel@vger.kernel.org
Subject: MAINTAINERS update for 2.4 SN support
Mail-Followup-To: marcelo@freak.distro.conectiva, jh@sgi.com,
	linux-ia64@linuxia64.org
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: KMail/1.5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302051022.07973.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick add of John Hesterberg as official maintainer of SN
support in the 2.4 tree.

Thanks,
Jesse


--- linux-2.4.20/MAINTAINERS	Thu Nov 28 15:53:08 2002
+++ linux-2.4.20-ia64/MAINTAINERS	Mon Feb  3 14:35:02 2003
@@ -710,6 +710,13 @@
 W:	http://www.linuxia64.org/
 S:	Maintained
 
+SN-IA64 (Itanium) SUB-PLATFORM
+P:	John Hesterberg
+M:	jh@sgi.com
+L:	linux-ia64@linuxia64.org
+W:	http://www.sgi.com/altix
+S:	Maintained
+
 IBM MCA SCSI SUBSYSTEM DRIVER
 P:	Michael Lang
 M:	langa2@kph.uni-mainz.de

