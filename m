Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263761AbTCUTUb>; Fri, 21 Mar 2003 14:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262726AbTCUTUT>; Fri, 21 Mar 2003 14:20:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45700
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263735AbTCUTSR>; Fri, 21 Mar 2003 14:18:17 -0500
Date: Fri, 21 Mar 2003 20:33:28 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212033.h2LKXSWc026383@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: sysfs typo fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/Documentation/filesystems/sysfs.txt linux-2.5.65-ac2/Documentation/filesystems/sysfs.txt
--- linux-2.5.65/Documentation/filesystems/sysfs.txt	2003-03-18 16:46:44.000000000 +0000
+++ linux-2.5.65-ac2/Documentation/filesystems/sysfs.txt	2003-03-18 18:09:49.000000000 +0000
@@ -60,7 +60,7 @@
 you publically humiliated and your code rewritten without notice. 
 
 
-An attriubte definition is simply:
+An attribute definition is simply:
 
 struct attribute {
         char                    * name;
@@ -261,7 +261,7 @@
 that point to the device's directory under root/.
 
 drivers/ contains a directory for each device driver that is loaded
-for devices on that particular bus (this assmumes that drivers do not
+for devices on that particular bus (this assumes that drivers do not
 span multiple bus types).
 
 
