Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUHYWq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUHYWq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUHYWq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:46:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:38811 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266469AbUHYWhG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:06 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733882056@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:28 -0700
Message-Id: <10934733881526@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1875, 2004/08/25 13:22:38-07:00, khali@linux-fr.org

[PATCH] I2C: update kernel credits/maintainers

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 CREDITS     |    6 ++++++
 MAINTAINERS |   30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)


diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	2004-08-25 14:52:44 -07:00
+++ b/CREDITS	2004-08-25 14:52:44 -07:00
@@ -735,6 +735,12 @@
 S: D-69231 Rauenberg
 S: Germany
 
+N: Jean Delvare
+E: khali@linux-fr.org
+W: http://khali.linux-fr.org/
+D: Several hardware monitoring drivers
+S: France
+
 N: Peter Denison
 E: peterd@pnd-pc.demon.co.uk
 W: http://www.pnd-pc.demon.co.uk/promise/
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2004-08-25 14:52:44 -07:00
+++ b/MAINTAINERS	2004-08-25 14:52:44 -07:00
@@ -199,6 +199,12 @@
 W:	http://linux.thorsten-knabe.de
 S:	Maintained
 
+ADM1025 HARDWARE MONITOR DRIVER
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	sensors@stimpy.netroedge.com
+S:	Maintained
+
 ADT746X FAN DRIVER
 P:	Colin Leroy
 M:	colin@colino.net
@@ -1327,6 +1333,18 @@
 W:	http://lsm.immunix.org
 S:	Supported
 
+LM83 HARDWARE MONITOR DRIVER
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	sensors@stimpy.netroedge.com
+S:	Maintained
+
+LM90 HARDWARE MONITOR DRIVER
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	sensors@stimpy.netroedge.com
+S:	Maintained
+
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP Dynamic Disks)
 P:	Richard Russon (FlatCap)
 M:	ldm@flatcap.org
@@ -1906,6 +1924,12 @@
 W:	http://www.winischhofer.net/linuxsisvga.shtml
 S:	Maintained	
 
+SMSC47M1 HARDWARE MONITOR DRIVER
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	sensors@stimpy.netroedge.com
+S:	Odd Fixes
+
 SMB FILESYSTEM
 P:	Urban Widmark
 M:	urban@teststation.com
@@ -2409,6 +2433,12 @@
 M:	johnpol@2ka.mipt.ru
 L:	sensors@stimpy.netroedge.com
 S:	Maintained
+
+W83L785TS HARDWARE MONITOR DRIVER
+P:	Jean Delvare
+M:	khali@linux-fr.org
+L:	sensors@stimpy.netroedge.com
+S:	Odd Fixes
 
 WAN ROUTER & SANGOMA WANPIPE DRIVERS & API (X.25, FRAME RELAY, PPP, CISCO HDLC)
 P:	Nenad Corbic

