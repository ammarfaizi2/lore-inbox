Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271334AbRHZRHX>; Sun, 26 Aug 2001 13:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271344AbRHZRHD>; Sun, 26 Aug 2001 13:07:03 -0400
Received: from [194.213.32.142] ([194.213.32.142]:49157 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S271334AbRHZRG6>;
	Sun, 26 Aug 2001 13:06:58 -0400
Date: Sun, 26 Aug 2001 19:05:04 +0200
From: Pavel Machek <pavel@bug.ucw.cz>
Message-Id: <200108261705.TAA24624@bug.ucw.cz>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Obvious doc fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- clean/Documentation/SubmittingDrivers	Tue May  8 11:42:15 2001
+++ linux/Documentation/SubmittingDrivers	Sun Aug 26 19:04:28 2001
@@ -2,8 +2,8 @@
 ---------------------------------------
 
 This document is intended to explain how to submit device drivers to the
-Linux 2.2 and 2.4test kernel trees. Note that if you are interested in video
-card drivers you should probably talk to XFree86 (http://wwww.xfree86.org) 
+Linux 2.2 and 2.4 kernel trees. Note that if you are interested in video
+card drivers you should probably talk to XFree86 (http://www.xfree86.org) 
 instead.
 
 Also read the Documentation/SubmittingPatches document.
@@ -34,7 +34,7 @@
 	maintainer does not respond or you cannot find the appropriate
 	maintainer then please contact Alan Cox <alan@lxorguk.ukuu.org.uk>
 
-Linux 2.4test:
+Linux 2.4:
 	This kernel tree is under active development. The same rules apply
 	as 2.2 but you may wish to submit your driver via linux-kernel (see
 	resources) and follow that list to track changes in API's. These
