Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265563AbSKABT6>; Thu, 31 Oct 2002 20:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265565AbSKABT6>; Thu, 31 Oct 2002 20:19:58 -0500
Received: from [205.144.50.230] ([205.144.50.230]:8970 "EHLO
	sdadmailinter.alldata.net") by vger.kernel.org with ESMTP
	id <S265563AbSKABT5>; Thu, 31 Oct 2002 20:19:57 -0500
Message-ID: <5789A42DD684734298BF9EC852D3511156E3CC@scad1exis02.alldata.net>
From: "Balint, Jess" <JBalint@alldata.net>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Wrong module name in help file.
Date: Thu, 31 Oct 2002 20:24:56 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all kernel people. First of all, I appreciate all of you hard
work!

I have seen into the kernel section of ieee 1394 / firewire. I believe this
small patch to be neeeded. This is against 2.4.20-rc1.

--- Documentation/Configure.help.orig	Fri Nov  1 02:22:03 2002
+++ Documentation/Configure.help	Fri Nov  1 02:22:07 2002
@@ -26231,7 +26231,7 @@
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
   say M here and read Documentation/modules.txt.  The module
-  will be called amdtp.o.
+  will be called cmp.o.
 
 OHCI-DV I/O support
 CONFIG_IEEE1394_DV1394
