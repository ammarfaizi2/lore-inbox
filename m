Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbTBUPh3>; Fri, 21 Feb 2003 10:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbTBUPh3>; Fri, 21 Feb 2003 10:37:29 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:19931 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267506AbTBUPh1>; Fri, 21 Feb 2003 10:37:27 -0500
Date: Fri, 21 Feb 2003 16:47:21 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.21-pre4-bk] sonypi driver update
Message-ID: <20030221164721.J12004@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This very little patch does nothing but updating the copyright
information in sonypi driver files.

I am a bit ashamed to send just this but let's be consistent and
resync all :)

Marcelo, Alan, please apply.

Thanks,

Stelian.

===== Documentation/sonypi.txt 1.10 vs edited =====
--- 1.10/Documentation/sonypi.txt	Tue Jan 28 11:19:04 2003
+++ edited/Documentation/sonypi.txt	Tue Feb 18 11:33:56 2003
@@ -1,6 +1,6 @@
 Sony Programmable I/O Control Device Driver Readme
 --------------------------------------------------
-	Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+	Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
 	Copyright (C) 2001-2002 Alcôve <www.alcove.com>
 	Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
 	Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
===== include/linux/sonypi.h 1.8 vs edited =====
--- 1.8/include/linux/sonypi.h	Thu Jan  9 13:46:12 2003
+++ edited/include/linux/sonypi.h	Fri Feb 21 10:22:44 2003
@@ -1,7 +1,7 @@
 /* 
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
===== drivers/char/sonypi.h 1.15 vs edited =====
--- 1.15/drivers/char/sonypi.h	Wed Jan 29 11:51:20 2003
+++ edited/drivers/char/sonypi.h	Fri Feb 21 10:22:44 2003
@@ -1,7 +1,7 @@
 /* 
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
===== drivers/char/sonypi.c 1.13 vs edited =====
--- 1.13/drivers/char/sonypi.c	Wed Jan 29 11:49:19 2003
+++ edited/drivers/char/sonypi.c	Tue Feb 18 11:33:33 2003
@@ -1,7 +1,7 @@
 /*
  * Sony Programmable I/O Control Device driver for VAIO
  *
- * Copyright (C) 2001-2002 Stelian Pop <stelian@popies.net>
+ * Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
  *
  * Copyright (C) 2001-2002 Alcôve <www.alcove.com>
  *
-- 
Stelian Pop <stelian@popies.net>
