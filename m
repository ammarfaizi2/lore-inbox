Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUKILKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUKILKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUKILDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:03:14 -0500
Received: from smtp1.jazztel.es ([62.14.3.161]:47784 "EHLO smtp1.jazztel.es")
	by vger.kernel.org with ESMTP id S261508AbUKILBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:01:53 -0500
Message-ID: <4190A32E.6090200@wanadoo.es>
Date: Tue, 09 Nov 2004 11:59:58 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.4.3) Gecko/20041005
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6-bk 1/1] tg3: add license
Content-Type: multipart/mixed;
 boundary="------------000508030809010109000007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000508030809010109000007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi,

there is no license, yes it's GPL but...

-thanks-

--------------000508030809010109000007
Content-Type: text/plain;
 name="tg3_license.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tg3_license.diff"

diff -Nuar o/drivers/net/tg3.c n/drivers/net/tg3.c
--- o/drivers/net/tg3.c	2004-11-09 11:49:06.000000000 +0100
+++ n/drivers/net/tg3.c	2004-11-09 11:43:23.000000000 +0100
@@ -9,6 +9,26 @@
  * 	Copyright (C) 2000-2003 Broadcom Corporation.
  */
 
+/*
+ * This file is part of Linux.
+ *
+ * Linux is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License Version 2
+ * as published by the Free Software Foundation.
+ *
+ * Linux is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Linux; if not, write to:
+ *
+ *   Free Software Foundation Inc.
+ *   59 Temple Place, Suite 330
+ *   Boston MA  02111-1307  USA
+ */
+
 #include <linux/config.h>
 
 #include <linux/module.h>
diff -Nuar o/drivers/net/tg3.h n/drivers/net/tg3.h
--- o/drivers/net/tg3.h	2004-11-09 11:49:06.000000000 +0100
+++ n/drivers/net/tg3.h	2004-11-09 11:46:41.000000000 +0100
@@ -1,4 +1,4 @@
-/* $Id: tg3.h,v 1.37.2.32 2002/03/11 12:18:18 davem Exp $
+/*
  * tg3.h: Definitions for Broadcom Tigon3 ethernet driver.
  *
  * Copyright (C) 2001, 2002, 2003, 2004 David S. Miller (davem@redhat.com)
@@ -6,6 +6,26 @@
  * Copyright (C) 2004 Sun Microsystems Inc.
  */
 
+/*
+ * This file is part of Linux.
+ *
+ * Linux is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License Version 2
+ * as published by the Free Software Foundation.
+ *
+ * Linux is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Linux; if not, write to:
+ *
+ *   Free Software Foundation Inc.
+ *   59 Temple Place, Suite 330
+ *   Boston MA  02111-1307  USA
+ */
+
 #ifndef _T3_H
 #define _T3_H
 

--------------000508030809010109000007--



