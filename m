Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbSI0RWy>; Fri, 27 Sep 2002 13:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262549AbSI0RWy>; Fri, 27 Sep 2002 13:22:54 -0400
Received: from [216.40.201.6] ([216.40.201.6]:61969 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262548AbSI0RWq>; Fri, 27 Sep 2002 13:22:46 -0400
Date: Fri, 27 Sep 2002 14:24:38 -0300
To: elmer@ylenurme.ee
Cc: linux-kernel@vger.kernel.org
Subject: [patch] include missing on aironet4500.h
Message-ID: <20020927172438.GR20649@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
aris

--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aironet.patch"

--- linux-2.5.38-vanilla/drivers/net/aironet4500.h	2002-09-22 01:24:57.000000000 -0300
+++ linux-2.5.38/drivers/net/aironet4500.h	2002-09-27 11:26:50.000000000 -0300
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 */
+#include <linux/tqueue.h>
 #include <linux/802_11.h>
 
 //damn idiot PCMCIA stuff

--ev7mvGV+3JQuI2Eo--
